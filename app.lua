SY = nil

Citizen.CreateThread(function()
	while SY == nil do
		TriggerEvent('sy:getSharedObject', function(obj) SY = obj end)
		Citizen.Wait(0)
	end

	while not SY.IsPlayerLoaded() do
		Citizen.Wait(500)
  end

  SY.TriggerServerCallback('sy_app:getPresence', function (res)
    while true do
      -- This is the Application ID (Replace this with you own)
      SetDiscordAppId(res.appId)
      -- Here you will have to put the image name for the "large" icon.
      SetDiscordRichPresenceAsset(res.assetName)

      -- (11-11-2018) New Natives:

      -- Here you can add hover text for the "large" icon.
      SetDiscordRichPresenceAssetText(res.text)

      -- Here you will have to put the image name for the "small" icon.
      SetDiscordRichPresenceAssetSmall(res.smallAssetName)

      -- Here you can add hover text for the "small" icon.
      SetDiscordRichPresenceAssetSmallText(res.sammAssetText)


      -- (26-02-2021) New Native:

      --[[
          Here you can add buttons that will display in your Discord Status,
          First paramater is the button index (0 or 1), second is the title and
          last is the url (this has to start with "fivem://connect/" or "https://")
      ]]--
      if res.buttons ~= nil and res.buttons[1] then
        SetDiscordRichPresenceAction(0, res.buttons[1].text, res.buttons[1].url)
      end
      if res.buttons ~= nil and res.buttons[2] then
        SetDiscordRichPresenceAction(1, res.buttons[2].text, res.buttons[2].url)
      end
      -- if res.buttons ~= nil and res.buttons[3] then
      --   SetDiscordRichPresenceAction(2, res.buttons[3].text, res.buttons[3].url)
      -- end
      -- SetDiscordRichPresenceAction(1, "Second Button!", "fivem://connect/localhost:30120")

      -- It updates every minute just in case.
      Citizen.Wait(60000)
    end

  end)
end)
