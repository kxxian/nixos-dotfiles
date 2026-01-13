{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = [
    pkgs.openssl
    pkgs.pkg-config
    pkgs.nodejs
  ];

  OPENSSL_DIR = pkgs.openssl.outPath;
  OPENSSL_LIB_DIR = "${pkgs.openssl.outPath}/lib";
  OPENSSL_INCLUDE_DIR = "${pkgs.openssl.outPath}/include";
}
