vRP = Proxy.getInterface("vRP")

CreateThread(function()

	for Name, v in pairs(Config.Scrapyards) do 
		local Scrapyard = lib.points.new({ coords = v.Coords, distance = 5 })
		
		function Scrapyard:onEnter() 
			if IsPedInAnyVehicle(PlayerPedId()) then
				lib.showTextUI('Tryk [E] for at skrotte køretøjet') 
			end
		end

		function Scrapyard:onExit() lib.hideTextUI() end
		 
		function Scrapyard:nearby()
			DrawMarker(27, self.coords.x, self.coords.y, self.coords.z, 0, 0, 0, 0, 0, 0, 5.75, 5.75, 5.75, 53, 146, 0, 100, 0, 0, 0, 50)
			if IsControlJustReleased(0, 38) and IsPedInAnyVehicle(PlayerPedId()) then
				local veh = GetVehiclePedIsUsing(PlayerPedId(), false)	

				if GetPedInVehicleSeat(veh, -1) == PlayerPedId() and veh ~= nil then
					local plate = GetVehicleNumberPlateText(veh)

					if string.sub(plate, 1, 8) == "P " .. vRP.getRegistrationNumber({}) then
						lib.notify({ title = v.Name, description = "Du kan ikke skrotte dit eget køretøj!", type = 'error' })
					else
						if string.sub(plate, 1, 2) == "P " then -- PLAYER VEHICLE
							local selled = lib.callback.await('scrap:SellVehicle', false, GetVehicleClass(veh), true)
						else -- NPC VEHICLE
							local selled = lib.callback.await('scrap:SellVehicle', false, nil, false)
						end
						DeleteEntity(veh)
					end
				else
					lib.notify({ title = v.Name, description = 'Du skal sidde i køretøjet for at skrotte det!', type = 'error' })
				end
			end
		end 

		-- { Create blip } --
		local stationBlip = AddBlipForCoord(v.Coords)
		SetBlipSprite(stationBlip, 467)
		SetBlipDisplay(stationBlip, 2)
		SetBlipScale(stationBlip, 0.6)
		SetBlipColour(stationBlip, 69)
		SetBlipScale(blip,0.6)
		SetBlipAlpha(stationBlip, 255)
		SetBlipAsShortRange(stationBlip, true)
		BeginTextCommandSetBlipName("String")
		AddTextComponentString(v.Name)
		EndTextCommandSetBlipName(stationBlip)
	end

end)