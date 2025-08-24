{
pkgs,
config,
lib,
...
}: {
    services.duckdns = {
        enable = true;
        domains = ["hexolexo"];
        tokenFile = "";
    };
}
