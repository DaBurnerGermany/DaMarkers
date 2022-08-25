ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
    end
    
end)


local playerJob = nil 



RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
    PlayerData = ESX.GetPlayerData()
end)



Citizen.CreateThread(function()
	while true do
	
		if ESX ~= nil and ESX.PlayerData ~= nil and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name ~= nil and ESX.PlayerData.job.name ~= playerJob then
			playerJob = ESX.PlayerData.job.name
		end
		Citizen.Wait(1000)
	end
end)




Citizen.CreateThread(function()
	while true do		
		Citizen.Wait(1)
		local playerCoords = GetEntityCoords(PlayerPedId())
		local executeSleep = true
		for k,v in pairs(Config.Spots) do
			if v.requiredJob == nil or v.requiredJob == playerJob then
                local distance = Vdist(playerCoords, v.x, v.y, v.z)
			
                if distance < Config.DrawDistance then
                    DrawMarker(
                        Config.Marker.Type
                        , v.x
                        , v.y
                        , v.z
                        , Config.Marker.dirX
                        , Config.Marker.dirY
                        , Config.Marker.dirZ
                        , Config.Marker.rotX
                        , Config.Marker.rotY
                        , Config.Marker.rotZ
                        , Config.Marker.scaleX
                        , Config.Marker.scaleY
                        , Config.Marker.scaleZ
                        , Config.Marker.red
                        , Config.Marker.green
                        , Config.Marker.blue
                        , Config.Marker.alpha
                        , Config.Marker.bobUpAndDown
                        , Config.Marker.faceCamera
                        , Config.Marker.p19
                        , Config.Marker.rotate
                        , Config.Marker.textureDict
                        , Config.Marker.textureName
                        , Config.Marker.drawOnEnts
                    )
                    executeSleep = false
                end
				
            end
		end 
			
		if executeSleep then
			Citizen.Wait(1000)
		end
	end
end)

