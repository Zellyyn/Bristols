ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

RegisterServerEvent('esx_gym:hireBmx')
AddEventHandler('esx_gym:hireBmx', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.get('money') >= 250 then
		xPlayer.removeMoney(250)
		notification("Vous avez louer un ~g~BMX")
    elseif xPlayer.get('bank') >= 250 then
		xPlayer.removeAccountMoney('bank', 250)
		notification("Vous avez louer un ~g~BMX")
    else
      TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas assez d\'argent sur vous ni sur votre carte bancaire')
    end
end)

RegisterServerEvent('esx_gym:checkChip')
AddEventHandler('esx_gym:checkChip', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local oneQuantity = xPlayer.getInventoryItem('gym_membership').count
	
	if oneQuantity > 0 then
		TriggerClientEvent('esx_gym:trueMembership', source) -- true
	else
		TriggerClientEvent('esx_gym:falseMembership', source) -- false
	end
end)

ESX.RegisterUsableItem('gym_bandage', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('gym_bandage', 1)	
	
	TriggerClientEvent('esx_gym:useBandage', source)
end)

RegisterServerEvent('esx_gym:buyBandage')
AddEventHandler('esx_gym:buyBandage', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.get('money') >= 50 then
		xPlayer.removeMoney(50)
		xPlayer.addInventoryItem('gym_bandage', 1)	
		notification("Vous avez acheté un ~g~bandage")
    elseif xPlayer.get('bank') >= 50 then
		xPlayer.removeAccountMoney('bank', 50)
		xPlayer.addInventoryItem('gym_bandage', 1)	
		notification("Vous avez acheté un ~g~bandage")
    else
      TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas assez d\'argent sur vous ni sur votre carte bancaire')
    end
end)

RegisterServerEvent('esx_gym:buyMembership')
AddEventHandler('esx_gym:buyMembership', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.get('money') >= 800 then
		xPlayer.removeMoney(800)
		xPlayer.addInventoryItem('gym_membership', 1)	
		notification("Vous avez acheté un~g~ ticket d'Adhésion")
		TriggerClientEvent('esx_gym:trueMembership', source)
    elseif xPlayer.get('bank') >= 800 then
		xPlayer.removeAccountMoney('bank', 800)
		xPlayer.addInventoryItem('gym_membership', 1)	
		notification("Vous avez acheté un~g~ ticket d'Adhésion")
		TriggerClientEvent('esx_gym:trueMembership', source)
    else
      TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas assez d\'argent sur vous ni sur votre carte bancaire')
    end
end)


RegisterServerEvent('esx_gym:buyProteinshake')
AddEventHandler('esx_gym:buyProteinshake', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.get('money') >= 6 then
		xPlayer.removeMoney(6)
		xPlayer.addInventoryItem('protein_shake', 1)	
		notification("Vous avez acheté un ~g~sachet de protéine")
    elseif xPlayer.get('bank') >= 6 then
		xPlayer.removeAccountMoney('bank', 6)
		xPlayer.addInventoryItem('protein_shake', 1)	
		notification("Vous avez acheté un ~g~sachet de protéine")
    else
      TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas assez d\'argent sur vous ni sur votre carte bancaire')
    end
end)

ESX.RegisterUsableItem('protein_shake', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('protein_shake', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 350000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Vous avez bu un~g~ sachet protéine')

end)

RegisterServerEvent('esx_gym:buyWater')
AddEventHandler('esx_gym:buyWater', function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.get('money') >= 1 then
		xPlayer.removeMoney(1)
		xPlayer.addInventoryItem('water', 1)	
		notification("Vous avez acheté de l'~g~Eau")
    elseif xPlayer.get('bank') >= 1 then
		xPlayer.removeAccountMoney('bank', 1)
		xPlayer.addInventoryItem('water', 1)	
		notification("Vous avez acheté de l'~g~Eau")
    else
      TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas assez d\'argent sur vous ni sur votre carte bancaire')
    end
end)

RegisterServerEvent('esx_gym:buySportlunch')
AddEventHandler('esx_gym:buySportlunch', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.get('money') >= 2 then
		xPlayer.removeMoney(2)
		xPlayer.addInventoryItem('sportlunch', 1)	
		notification("Vous avez acheté un ~g~déjeuner Sportif")
    elseif xPlayer.get('bank') >= 1 then
		xPlayer.removeAccountMoney('bank', 2)
		xPlayer.addInventoryItem('sportlunch', 1)	
		notification("Vous avez acheté un ~g~déjeuner Sportif")
    else
      TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas assez d\'argent sur vous ni sur votre carte bancaire')
    end
end)

ESX.RegisterUsableItem('sportlunch', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('sportlunch', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 350000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, 'Vous manger un ~g~déjeuner Sportif')

end)

RegisterServerEvent('esx_gym:buyPowerade')
AddEventHandler('esx_gym:buyPowerade', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.get('money') >= 4 then
		xPlayer.removeMoney(4)
		xPlayer.addInventoryItem('powerade', 1)	
		notification("Vous avez acheté un ~g~déjeuner Sportif")
    elseif xPlayer.get('bank') >= 1 then
		xPlayer.removeAccountMoney('bank', 4)
		xPlayer.addInventoryItem('powerade', 1)	
		notification("Vous avez acheté un ~g~déjeuner Sportif")
    else
      TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas assez d\'argent sur vous ni sur votre carte bancaire')
    end
end)

ESX.RegisterUsableItem('powerade', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('powerade', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 700000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Vous avez bu une ~g~powerade')

end)

-- FUNCTIONS IN THE FUTURE (COMING SOON...)

--RegisterServerEvent('esx_gym:trainArms')
--AddEventHandler('esx_gym:trainArms', function()
	
--end)

--RegisterServerEvent('esx_gym:trainChins')
--AddEventHandler('esx_gym:trainArms', function()
	
--end)

--RegisterServerEvent('esx_gym:trainPushups')
--AddEventHandler('esx_gym:trainPushups', function()
	
--end)

--RegisterServerEvent('esx_gym:trainYoga')
--AddEventHandler('esx_gym:trainYoga', function()
	
--end)

--RegisterServerEvent('esx_gym:trainSitups')
--AddEventHandler('esx_gym:trainSitups', function()
	
--end)

function notification(text)
	TriggerClientEvent('esx:showNotification', source, text)
end