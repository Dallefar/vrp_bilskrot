local Proxy = module("vrp", "lib/Proxy")
local webhook = module("vrp","cfg/webhooks")

vRP = Proxy.getInterface("vRP") 

lib.callback.register('scrap:SellVehicle', function(source, VehicleClass, playerOwned)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local HasRank = false

	if playerOwned then
		for k,v in ipairs(Config.Groups) do
			if vRP.hasGroup({user_id, v}) then
				HasRank = true 
			end
		end
	end

	if playerOwned and HasRank then
		return true, vRP.giveBankMoney({ user_id, Config.ScrapPrices[VehicleClass] }), TriggerClientEvent('ox_lib:notify', source, { description = "Du har skrottet kørerøjet og modtager ".. Config.ScrapPrices[VehicleClass] .." DKK", type = "success" })
	elseif not playerOwned then
		return true, vRP.giveBankMoney({ user_id, Config.NpcCarPrice }), TriggerClientEvent('ox_lib:notify', source, { description = "Du har skrottet kørerøjet og modtager ".. Config.NpcCarPrice .." DKK", type = "success" })
	else
		TriggerClientEvent('ox_lib:notify', source, { description = "Du er ikke en mekaniker, du kan ikke sælge biler her!", type = "error" })
	end

	return false
end)