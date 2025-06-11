let
 pkgs = import (fetchTarball "https://github.com/rstats-on-nix/nixpkgs/archive/2025-06-02.tar.gz") {};

  rpkgs = builtins.attrValues {
    inherit (pkgs.rPackages) 
    quarto
    rix
    tarchetypes
    targets
    withr
      ;
  };

 rUM = (pkgs.rPackages.buildRPackage {
      name = "rUM";
      src = pkgs.fetchgit {
        url = "https://github.com/RaymondBalise/rUM/";
        rev = "7f8863bbcffabe7a9a17441acc16472ab4215eac";
        sha256 = "sha256-ZRSG4hIwEZY+7b6EimVhWc7OUB27Xag+nusqc1MWEmA=";
      };
      propagatedBuildInputs = builtins.attrValues {
        inherit (pkgs.rPackages) 
          bookdown
          conflicted
          glue
          gtsummary
          here
          knitr
          labelled
          quarto
          readr
          rio
          rlang
          rmarkdown
          roxygen2
          stringr
          table1
          tidymodels
          tidyverse
          usethis;
      };
    });

 system_packages = builtins.attrValues {
  inherit (pkgs) R glibcLocalesUtf8 quarto nix;
};

  in
  pkgs.mkShell {
    LOCALE_ARCHIVE = if pkgs.system == "x86_64-linux" then  "${pkgs.glibcLocalesUtf8}/lib/locale/locale-archive" else "";
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";

    buildInputs = [ system_packages rpkgs rUM ];

    shellHook = '' Rscript -e "targets::tar_make()" '';
  }

