SY = nil

TriggerEvent('sy:getSharedObject', function(obj)
  SY = obj
end)

SY.RegisterServerCallback('sy_app:getPresence', function (source, cb)

  return cb({
    appId = 869688927194316870,
    assetName = "alive",
    text = "파이브엠 천사들의 도시 RPG형 인생모드",
    smallAssetName = "alive",
    smallAssetText = "파이브엠 천사들의 도시 RPG형 인생모드",
    buttons = {
      [1] = {
        text = "공식 홈페이지", url="https://official.lacity.online",
      },
      [2] = {
        text = "공식 디스코드", url="https://discord.lacity.online",
      },
      -- [2] = {
      --   text = "GAME START", url="fivem://connect.lacity.online",
      -- }
    }
  })
end)