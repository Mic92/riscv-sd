{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/staging";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };
  outputs =
    { nixpkgs, nixos-hardware, ... }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "riscv64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSupportedSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      packages = forAllSupportedSystems (system: rec {
        default = sd-image;
        sd-image =
          (import "${nixpkgs}/nixos" {
            configuration = (
              { pkgs, lib, ... }:
              {
                imports = [ "${nixos-hardware}/milkv/pioneer/sd-image-installer.nix" ];
                nixpkgs.buildPlatform.system = system;
                nixpkgs.hostPlatform.system = "riscv64-linux";
                services.openssh.enable = true;
                environment.systemPackages = map lib.lowPrio [
                  pkgs.curl
                  pkgs.gitMinimal
                ];
                users.users.root.openssh.authorizedKeys.keys = [
                  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKbBp2dH2X3dcU1zh+xW3ZsdYROKpJd3n13ssOP092qE"
                  "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDkcVMirdcsKzWkJbCeFIAZQrMod9nn2mOI9QIt0k9KX5agflfIaCbhnuQP5DE3RQqWWHyTy8N4TZUddD2BYw84v44w4jCGOqFq8fB773AeYQ88HJWvPsCyif5KsAy195oIfDbWMvmmEJIRKzzV1igyBkiNyGFN1X/YHQ8beYUyKNHTOEWEcXFs8I1L3LwHaqWfdV07NwRH39v1mR+7fJGLJy71ta+RjNL4swxToiCsVFe25Qd4D9LBCBfQ2qLRl5+nBvIoitzSRu9LdNDzvnT06wLxJtLPGlkIKuhnKf91IvXoQie8wTpUM6h4D7ahOCcECyeGDdDFKq4jzsUYBYCaI6+eEtKRuwVUQrxcg9k6QUGxn64fVQHRt4A+JH4MeM8v+iGkqw80anMtY93Kwoe7a6fX1tuMvhL+fhKs+sWC9CiDALwHcWYwSzuHjRKUyJxIDhOIw2WF63ik+N+qAkAgEAoOqSMxaPPqbMVukFtdt67scUFZc+rwSwBiYG0ZdRMhY74m3VU4Qr291qdeVrgGSoVA21hZIwLCclV0rixXfUh1ZsaPv2n5HiC+V/teKF6g+RvdLpMKlzWjMkspOm86N9Mz/LS1Fpbflugo2DZb2qTzGaFE3Ry/duHYO8fReEzdMvgvLBuEJ4Xf1ocHjgNfUJGldG0d1YiehLN9Rb4G4Q=="
                  "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCpcdlOCtY8rqKN+OwZVW9WTJ3rE0ducU5V+7JAB0Hof2kfHwh8GMROXq3oIA3BkqsWTtrbJgZTiXP9FnRHxccL+OqevlhxRZxEEaeMd/OlJhJopbbzASaXhY7gsLlftw27J3HGzBbsc17z/1R7JqMo3ebMd+Zjv/AT/WHuxLA4oDm/7m9R1F8V/T1tNFReeo0qHXG42oQ39GR5Q4uWHalwTsI0ycneUW48qnzA+JqEZMZl6Jmitg8d0t9nWPwB0MKHD2egdl7eYR4e3rSuK8jBVcZRMAoSrNsy9xguu6C1by5oV6z0SFerBVe8zyXDHKYDVEsjULLgeEPtSxaZh7Eh7VzIQTiWZtdjljpqYAtwK/dTXWA/kH0wOedPXoYjt1BUA8Gxqw6RSAgyBLwLMh03J4ARvpZeOeVylOiq9vvZyWhSOZ9YLDSg3mQ/b0dX39c8M67FAvnGeXXAPBdN0WovPemr9V4Ns2wo1cT0RBOBbTuomvPHaAhr5mok9dlTbtK68hfEiljfGh9NRPK2I7z4yAKAMDeIOcx5bN1G5HKmcKINAnqEGr9sbgcjL1SsDyr5DvanIlLGgvxd5ID7rj22A9NVGPnEnK+hlnCgB16Z3xPQi4cTccgon2tkU+CjZ40R4rV1R6b7KnJikDrnGry2Wu6ZufqR17ydvYLPdEV/aQ=="
                  "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBBYcRp+3vOyxwxDybx5qgXRK1Cms1xnhGDYUJtPpOmFhNEcYIo9VHQjn4A7f5EKxxpSzJTFO71d4nyRsSfk695g="
                  "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBBabFSD7fWppDqkpuBgkezQh1AiNK1NltrHBoI2+qGIMx5RjbkzeJ6ra1d/G/FeXrvVuQ4joZ8VDkv0s3Oyr/P8="
                  "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBG0TjS/uGWx3om7H8NsEZR6fA2SmEq89SxBfb43Mwe91fi7+O8oxrdQgcjk5Xo9cvSGmSKYIxH+TJVoNJBh5dkU="
                  "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBL0A23EsrRlaFGJxX3vpJSfcxQEDy6N/ikzqtdTTTV8jAYfVuBeUzrOoPGQD1crDBQSAoQrsT2NsUt1nK82Fejc="
                  "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBLk2I7EFdw+L93cLtN1mE156lyZ+b9lh0vzdtT8U/bxcqxtd61MssI65Q3WaTfaUIRU/B2kojqUHxQ7VlNiq5oM="
                ];
                system.stateVersion = "24.05";
              }
            );
            inherit system;
          }).config.system.build.sdImage;
      });
    };
}
