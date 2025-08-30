{ hostConfig, ... }:
{
  time = {
    timeZone = hostConfig.timeZone;
    hardwareClockInLocalTime = hostConfig.dualBoot or false;
  };
}
