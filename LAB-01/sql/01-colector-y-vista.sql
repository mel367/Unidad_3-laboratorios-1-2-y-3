-- LAB-01 | Actividad 2

CREATE SCHEMA IF NOT EXISTS dba;
REVOKE ALL ON SCHEMA dba FROM PUBLIC;

CREATE OR REPLACE VIEW dba.bitacora AS
SELECT t.n AS num, t.linea
FROM regexp_split_to_table(
         pg_read_file(pg_current_logfile()),
         E'\\n'
     ) WITH ORDINALITY AS t(linea, n)
WHERE t.linea <> '';

-- Comprobaciones:
SELECT pg_current_logfile();
SELECT num, linea FROM dba.bitacora ORDER BY num DESC LIMIT 10;
SELECT linea FROM dba.bitacora WHERE linea ~ '(FATAL|ERROR)';
