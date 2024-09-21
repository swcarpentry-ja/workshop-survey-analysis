# Extract names of packages used in this project
pkg_lines <- readLines("packages.R")
project_pkgs <- pkg_lines[grep("library\\(", pkg_lines)]
project_pkgs <- gsub("library\\(|\\)", "", project_pkgs)

# Snapshot rix environment
rix::rix(
  r_ver = "4.4.1",
  r_pkgs = project_pkgs,
  system_pkgs = NULL,
  git_pkgs = NULL,
  ide = "code",
  project_path = ".",
  overwrite = TRUE
)
