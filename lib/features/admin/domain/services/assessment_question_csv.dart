import 'dart:convert';

import 'package:talex_platform/features/admin/domain/entities/assessment_question.dart';
import 'package:talex_platform/features/admin/domain/services/assessment_question_defaults.dart';

enum AssessmentCsvError {
  unreadable,
  empty,
  missingColumns,
  invalidRow,
  duplicate,
}

class AssessmentCsvException implements Exception {
  const AssessmentCsvException(this.error, {this.row = 0, this.detail = ''});
  final AssessmentCsvError error;

  /// Número de fila tal como se ve en la hoja de cálculo (el encabezado es 1).
  final int row;
  final String detail;
  @override
  String toString() => 'AssessmentCsvException($error, row $row, $detail)';
}

/// Lee el CSV del banco de preguntas (mismas columnas que la plantilla:
/// n, codigo, frente, dimension_A, dimension_B, formato, instruccion,
/// enunciado_A, enunciado_B, opcion_1..5, tiempo_limite_seg).
abstract final class AssessmentQuestionCsv {
  static const requiredColumns = ['codigo', 'frente', 'enunciado_a'];

  static List<AssessmentQuestion> parseBytes(List<int> bytes) {
    String text;
    try {
      text = utf8.decode(bytes);
    } on FormatException {
      // Excel suele exportar en Latin-1.
      text = latin1.decode(bytes);
    }
    return parse(text);
  }

  static List<AssessmentQuestion> parse(String text) {
    final content = text.startsWith('﻿') ? text.substring(1) : text;
    final firstLine = content.split('\n').first;
    final delimiter =
        ';'.allMatches(firstLine).length > ','.allMatches(firstLine).length
        ? ';'
        : ',';
    final rows = _rows(content, delimiter);
    if (rows.isEmpty) {
      throw const AssessmentCsvException(AssessmentCsvError.empty);
    }
    final header = [for (final cell in rows.first) cell.trim().toLowerCase()];
    final missing = [
      for (final column in requiredColumns)
        if (!header.contains(column)) column,
    ];
    if (missing.isNotEmpty) {
      throw AssessmentCsvException(
        AssessmentCsvError.missingColumns,
        row: 1,
        detail: missing.join(', '),
      );
    }
    final questions = <AssessmentQuestion>[];
    final codes = <String>{};
    for (var index = 1; index < rows.length; index++) {
      final cells = rows[index];
      if (cells.every((cell) => cell.trim().isEmpty)) continue;
      String cell(String column) {
        final position = header.indexOf(column);
        return position < 0 || position >= cells.length
            ? ''
            : cells[position].trim();
      }

      final code = cell('codigo').toUpperCase();
      final statementA = cell('enunciado_a');
      if (code.isEmpty || code.contains('/') || statementA.isEmpty) {
        throw AssessmentCsvException(
          AssessmentCsvError.invalidRow,
          row: index + 1,
        );
      }
      if (!codes.add(code)) {
        throw AssessmentCsvException(
          AssessmentCsvError.duplicate,
          row: index + 1,
          detail: code,
        );
      }
      final front = _front(cell('frente'));
      final statementB = cell('enunciado_b');
      final formatText = cell('formato').toLowerCase();
      final format = formatText.isEmpty
          ? (statementB.isEmpty
                ? AssessmentQuestionFormat.experience
                : AssessmentQuestionFormat.pair)
          : (formatText.contains('par') || formatText.contains('pair')
                ? AssessmentQuestionFormat.pair
                : AssessmentQuestionFormat.experience);
      final isPair = format == AssessmentQuestionFormat.pair;
      final defaults = AssessmentQuestionDefaults.optionsFor(format);
      final instruction = cell('instruccion');
      questions.add(
        AssessmentQuestion(
          code: code,
          order: int.tryParse(cell('n')) ?? questions.length + 1,
          front: front,
          format: format,
          dimensionA: cell('dimension_a'),
          dimensionB: isPair ? cell('dimension_b') : '',
          instruction: instruction.isEmpty
              ? AssessmentQuestionDefaults.instructionFor(front)
              : instruction,
          statementA: statementA,
          statementB: isPair ? statementB : '',
          options: [
            for (var option = 0; option < 5; option++)
              _option(cell('opcion_${option + 1}'), defaults[option]),
          ],
          timeLimitSeconds: int.tryParse(cell('tiempo_limite_seg')),
        ),
      );
    }
    if (questions.isEmpty) {
      throw const AssessmentCsvException(AssessmentCsvError.empty);
    }
    return questions;
  }

  static AssessmentFront _front(String value) {
    final text = value.toLowerCase();
    if (text.startsWith('2') ||
        text.contains('neces') ||
        text.contains('need')) {
      return AssessmentFront.needs;
    }
    if (text.startsWith('3') ||
        text.contains('capac') ||
        text.contains('capab')) {
      return AssessmentFront.capabilities;
    }
    return AssessmentFront.coreValues;
  }

  // "1 = Nunca" -> "Nunca".
  static String _option(String value, String fallback) {
    final label = value.replaceFirst(RegExp(r'^\d+\s*=\s*'), '').trim();
    return label.isEmpty ? fallback : label;
  }

  static List<List<String>> _rows(String text, String delimiter) {
    final rows = <List<String>>[];
    var row = <String>[];
    final cell = StringBuffer();
    var quoted = false;
    for (var index = 0; index < text.length; index++) {
      final char = text[index];
      if (quoted) {
        if (char == '"') {
          if (index + 1 < text.length && text[index + 1] == '"') {
            cell.write('"');
            index++;
          } else {
            quoted = false;
          }
        } else {
          cell.write(char);
        }
      } else if (char == '"') {
        quoted = true;
      } else if (char == delimiter) {
        row.add(cell.toString());
        cell.clear();
      } else if (char == '\n' || char == '\r') {
        if (char == '\r' &&
            index + 1 < text.length &&
            text[index + 1] == '\n') {
          index++;
        }
        row.add(cell.toString());
        cell.clear();
        rows.add(row);
        row = <String>[];
      } else {
        cell.write(char);
      }
    }
    if (cell.isNotEmpty || row.isNotEmpty) {
      row.add(cell.toString());
      rows.add(row);
    }
    return rows;
  }
}
