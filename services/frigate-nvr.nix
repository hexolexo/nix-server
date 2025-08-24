{...}: {
  services.frigate = {
    enable = true;
    hostname = "0.0.0.0"; # Listen on all interfaces
    #port = 5000;

    settings = {
      mqtt = {
        enabled = false; # Enable if you have MQTT broker
        # host = "localhost";
        # port = 1883;
      };

      cameras = {
        # Example camera configuration
        front_door = {
          ffmpeg = {
            inputs = [
              {
                path = "rtsp://steph:carmichael71SAB@192.168.0.2:554/ch01/1";
                roles = ["record"];
              }
              {
                path = "rtsp://steph:carmichael71SAB@192.168.0.2:554/ch02/1";
                roles = ["detect" "record"];
              }
              {
                path = "rtsp://steph:carmichael71SAB@192.168.0.2:554/ch03/1";
                roles = ["detect" "record"];
              }
            ];
          };
          detect = {
            width = 1920;
            height = 1080;
            fps = 5;
          };
          record = {
            enabled = true;
            retain = {
              days = 7;
              mode = "motion";
            };
          };
        };
      };

      detectors = {
        cpu1 = {
          type = "cpu";
        };
      };
    };
  };

  # Open firewall port
  networking.firewall.allowedTCPPorts = [5000];

  # Create storage directory
  systemd.tmpfiles.rules = [
    "d /var/lib/frigate 0755 frigate frigate"
  ];
}
