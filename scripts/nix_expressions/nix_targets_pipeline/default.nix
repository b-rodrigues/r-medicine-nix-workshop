# This file was generated by the {rix} R package v0.17.0 on 2025-06-02
# with following call:
# >rix(r_ver = "4.2.2",
#  > r_pkgs = c("targets",
#  > "tarchetypes",
#  > "rmarkdown"),
#  > system_pkgs = "pandoc",
#  > git_pkgs = list(list(package_name = "housing",
#  > repo_url = "https://github.com/rap4all/housing/",
#  > branch_name = "fusen",
#  > commit = "1c860959310b80e67c41f7bbdc3e84cef00df18e")),
#  > ide = "none",
#  > project_path = ".",
#  > overwrite = TRUE,
#  > shell_hook = "Rscript -e 'targets::tar_make()'")
# It uses the `rstats-on-nix` fork of `nixpkgs` which provides improved
# compatibility with older R versions and R packages for Linux/WSL and
# Apple Silicon computers.
# Report any issues to https://github.com/ropensci/rix
let
 pkgs = import (fetchTarball "https://github.com/rstats-on-nix/nixpkgs/archive/2023-02-13.tar.gz") {};
 
  rpkgs = builtins.attrValues {
    inherit (pkgs.rPackages) 
      rmarkdown
      tarchetypes
      targets;
  };
 
    housing = (pkgs.rPackages.buildRPackage {
      name = "housing";
      src = pkgs.fetchgit {
        url = "https://github.com/rap4all/housing/";
        rev = "1c860959310b80e67c41f7bbdc3e84cef00df18e";
        sha256 = "sha256-s4KGtfKQ7hL0sfDhGb4BpBpspfefBN6hf+XlslqyEn4=";
      };
      propagatedBuildInputs = builtins.attrValues {
        inherit (pkgs.rPackages) 
          dplyr
          ggplot2
          janitor
          purrr
          readxl
          rlang
          rvest
          stringr
          tidyr;
      };
    });
      
  system_packages = builtins.attrValues {
    inherit (pkgs) 
      glibcLocales
      nix
      pandoc
      R
      which;
  };
  
  shell = pkgs.mkShell {
    LOCALE_ARCHIVE = if pkgs.system == "x86_64-linux" then "${pkgs.glibcLocales}/lib/locale/locale-archive" else "";
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    
    buildInputs = [ housing rpkgs system_packages ];
    shellHook = "Rscript -e 'targets::tar_make()'";
  }; 
in
  {
    inherit pkgs shell;
  }
