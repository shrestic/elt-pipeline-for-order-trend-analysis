{% macro remove_double_quote(column_name) %}
    left(right({{ column_name }}, len({{ column_name }}) - 1), len({{ column_name }}) - 2)
{% endmacro %}