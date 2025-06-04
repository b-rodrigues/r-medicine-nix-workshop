library(rix)

rix(
  date = "2025-06-02",
  r_pkgs = c(
    "chronicler",
    "dplyr",
    "ggdag",
    "igraph",
    "quarto",
    "reticulate",
    "visNetwork"
  ),
  git_pkgs = list(
    list(
      package_name = "rix",
      repo_url = "https://github.com/ropensci/rix/",
      commit = "HEAD"
    ),
    list(
      package_name = "rixpress",
      repo_url = "https://github.com/b-rodrigues/rixpress",
      commit = "HEAD"
    )
  ),
  py_conf = list(
    py_version = "3.13",
    py_pkgs = c(
      "polars"
    )
  ),
  ide = "none",
  project_path = ".",
  overwrite = TRUE
)
