{ config, pkgs, ... }:
{
    # Just the step-ca service
    users.users.step-ca = {
        isSystemUser = true;
        group = "step-ca";
        home = "/var/lib/step-ca";
        createHome = true;
    };

    users.groups.step-ca = {};

    services.step-ca = {
        enable = true;
        port = 9000;
        intermediatePasswordFile = "/run/keys/smallstep-password";
        address = "127.0.0.1";
        settings = {
            root = "/var/lib/step-ca/certs/root_ca.crt";
            federatedRoots = null;
            crt = "/var/lib/step-ca/certs/intermediate_ca.crt";
            key = "/var/lib/step-ca/secrets/intermediate_ca_key";
            address = "127.0.0.1:9000";
            dnsNames = [ "localhost" ];
            logger = {
                format = "text";
            };
            db = {
                type = "badgerv2";
                dataSource = "/var/lib/step-ca/db";
                badgerFileLoadingMode = "";
            };
            authority = {
                provisioners = [
                    {
                        type = "JWK";
                        name = "admin@vault.lan";
                        key = {
                            use = "sig";
                            kty = "EC";
                            kid = "JWxiJsmZ4lEGn0byNwtRrQujE9TBj1W8XbuRdkFhWNU";
                            crv = "P-256";
                            alg = "ES256";
                            x = "P9iAI9phHlVFeq06YbmeW_z8yQNMvdnma7abkkmuT6I";
                            y = "sTY5s4L5KtyEcOhOvVpE9Jza8pVo48QOXRCXnwb3UGI";
                        };
                        encryptedKey = "eyJhbGciOiJQQkVTMi1IUzI1NitBMTI4S1ciLCJjdHkiOiJqd2sranNvbiIsImVuYyI6IkEyNTZHQ00iLCJwMmMiOjYwMDAwMCwicDJzIjoiS3R2MmVkaHp5cWd0c09id0FoNlFrQSJ9.NUjhets58b-NIgiCtvSc8fSEvIsQ7ZdbY9BKfB7PhfUiJVYMKkLNlw.Wr0xn11Gjbwem-Es.feZl4oPamdhr_D5qiUvu3BFoznGJ3xtcxyE7VXgigRWwghGNQI4wUykXCADMOZpyDGMHgTClvmY7LffLokGVey58Tx1sI_B0_GxUxP-LoXX_JxeMiwyOE7vvlMeCXhbjN31aQl38WGW6m49n5WLRoTch_zv4Oj8wvHdsgrLz5n0OVdeFVJ7OZwcxxt12p4_hIcUUcL-YY1ASSDSm03EoG_E5lLNEvWx3gsyxIIsNDwDTMMrvjnMis-Dq0SMlhurcgCiGnWE3k99CtmD8kKUA_WGGy9iX8bN-F2dEEcmq_x6XFUPxavpt9hNfXU2w-VR_SL73YWZtFwJVqjiUo90.sps7NADtlwLVxyV9rjcGAQ";
                    }
                ];
            };
            tls = {
                cipherSuites = [
                    "TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256"
                    "TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256"
                ];
                minVersion = 1.2;
                maxVersion = 1.3;
                renegotiation = false;
            };
        };
    };

    networking.firewall.allowedTCPPorts = [ 9000 ];
}
