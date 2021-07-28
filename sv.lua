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

function ExtractIdentifiers(src)

  local identifiers = {
      steam = "",
      ip = "",
      discord = "",
      license = "",
      xbl = "",
      live = ""
  }

  for i = 0, GetNumPlayerIdentifiers(src) - 1 do
      local id = GetPlayerIdentifier(src, i)

      if string.find(id, "steam") then
          identifiers.steam = id
      elseif string.find(id, "ip") then
          identifiers.ip = id
      elseif string.find(id, "discord") then
          identifiers.discord = id
      elseif string.find(id, "license") then
          identifiers.license = id
      elseif string.find(id, "xbl") then
          identifiers.xbl = id
      elseif string.find(id, "live") then
          identifiers.live = id
      end
  end

  return identifiers
end



function sendToDiscord (source,message,color,identifier, name)

  local _name = name == nil and GetPlayerName(source) or name
  local webhook = "https://discord.com/api/webhooks/869895546071052339/Iy7R3EZMq335XjA_PfIN-s44TZa-zfrvVE-9AqGXEb3stkPJa_asQAu4-RT_f88NAiWW"
  if not color then
      color = "16767235"
  end
  local sendD = {
      {
          ["color"] = color,
          ["title"] = message,
          ["description"] = "`Player`: **".._name.."**\nSteam: **"..identifier.steam.."** \nIP: **"..identifier.ip.."**\nDiscord: **"..identifier.discord.."**\nFivem: **"..identifier.license.."",
          ["footer"] = {
              ["text"] = "LAC © "..os.date("%x %X %p")
          },
      }
  }
  PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "Dev Tool Detector", embeds = sendD}), { ['Content-Type'] = 'application/json' })
end

local ban = true

RegisterServerEvent('sy_app:_dev')
AddEventHandler('sy_app:_dev', function ()
  local playerId = source
  local identifiers = ExtractIdentifiers(playerId)
  local xPlayer = SY.GetPlayerFromId(playerId)


  if xPlayer == nil then
    sendToDiscord(playerId, "Opened NUI Tools [ "..(ban and "BANNED" or "KICKED").." ]", 16744192, identifiers)
  else
    if xPlayer.getGroup() == 'admin' then
      return
    end
    sendToDiscord(playerId, "Opened NUI Tools [ "..(ban and "BANNED" or "KICKED").." ]", 16744192, identifiers, xPlayer.getName())
  end


  print("====================================================")
  print("*")
  print("* NUI TOOL DETECTION")
  print("*")
  print("----------------------------------------------------")
  print(playerId)
  print(SY.DumpTable(identifiers))
  print("====================================================")
  if ban then
    TriggerEvent('banCheater', playerId, "NUI Devtools 접근 권한 없음", false, "snoopy-droopy-pantsy")
    DropPlayer(playerId, "운영방침 위반으로 영구 이용제한 처리됐습니다.")
  else
    DropPlayer(playerId, "해당 툴에 접근 권한이 없습니다. 계속 시도 할 경우 정보통신망 이용촉진 및 정보보호에 관한 법률 위반으로 형사처벌 대상이 됩니다.")
  end
end)


RegisterCommand('aegisOn', function (source)
  local xPlayer = SY.GetPlayerFromId(source)

  if xPlayer.getGroup() == 'admin' then
    xPlayer.triggerEvent('sy_notifications:messageLeft', {
      head = "AEGIS ACTIVATED",
      title = "AEGIS NUI ACTIVATED",
      message = "NUI TOOL 방어가 시작됩니다."
    })
    ban = true
  else
    TriggerEvent('banCheater', playerId, "접근 권한 없음", false, "false-command-auth")
  end
end)
RegisterCommand('aegisOff', function (source)
  local xPlayer = SY.GetPlayerFromId(source)

  if xPlayer.getGroup() == 'admin' then
    xPlayer.triggerEvent('sy_notifications:messageLeft', {
      head = "AEGIS DE-ACTIVATED",
      title = "AEGIS NUI DE-ACTIVATED",
      message = "NUI TOOL 방어를 잠시 멈춥니다."
    })
    ban = false
  else
    TriggerEvent('banCheater', playerId, "접근 권한 없음", false, "false-command-auth")
  end
end)