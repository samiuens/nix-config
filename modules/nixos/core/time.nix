{ hostConfig, ... }:
{
  time.timeZone = hostConfig.timeZone;
}
