library(rixpress)
library(igraph)

list(
  rxp_py_file(
    name = mtcars_pl,
    path = 'data/mtcars.csv',
    read_function = "lambda x: polars.read_csv(x, separator='|')"
  ),

  rxp_py(
    name = mtcars_pl_am,
    py_expr = "mtcars_pl.filter(polars.col('am') == 1)",
    additional_files = "functions.py",
    serialize_function = "write_to_csv"
  ),

  rxp_r(
    name = mtcars_head,
    expr = my_head(mtcars_pl_am),
    additional_files = "functions.R",
    serialize_function = "my_write.csv",
    unserialize_function = "read.csv"
  ),

  rxp_py(
    name = mtcars_tail_py,
    py_expr = 'mtcars_head.tail()',
    additional_files = "functions.py",
    serialize_function = "write_to_csv",
    unserialize_function = "read_from_csv"
  ),

  rxp_r(
    name = mtcars_mpg,
    expr = dplyr::select(mtcars_tail_py, mpg),
    unserialize_function = "read.csv"
  ),

  rxp_qmd(
    name = page,
    qmd_file = "my_doc/page.qmd",
    additional_files = c("my_doc/content.qmd", "my_doc/images")
  )
) |>
  rixpress(project_path = ".")

# Plot DAG for CI
dag_for_ci()
