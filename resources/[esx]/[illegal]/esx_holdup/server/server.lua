local rob = false
local robbers = {}
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

RegisterServerEvent('esx_holdupstore:braquageshop')
AddEventHandler('esx_holdupstore:braquageshop', function(result)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()
	local mess     = result
	--print(text)
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		TriggerClientEvent('esx_breakingnews:braquageshop', xPlayers[i],mess)
	end

end)


RegisterServerEvent('esx_holdupstore:toofar')
AddEventHandler('esx_holdupstore:toofar', function(robb)
	local source = source
	local xPlayers = ESX.GetPlayers()
	rob = false
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' and 'gouvernement' then
			TriggerClientEvent('esx:showNotification', xPlayers[i], _U('robbery_cancelled_at') .. Stores[robb].nameofstore)
			TriggerClientEvent('esx_holdupstore:killblip', xPlayers[i])
		end
	end
	if(robbers[source])then
		TriggerClientEvent('esx_holdupstore:toofarlocal', source)
		robbers[source] = nil
		TriggerClientEvent('esx:showNotification', source, _U('robbery_has_cancelled') .. Stores[robb].nameofstore)
		local xPlayer = ESX.GetPlayerFromId(source)
		TriggerEvent('esx:holdupmagbot2',xPlayer.name,Stores[robb].nameofstore)
	end
end)

RegisterServerEvent('esx_holdupstore:rob')
AddEventHandler('esx_holdupstore:rob', function(robb)

	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	
	if Stores[robb] then

		local store = Stores[robb]

		if (os.time() - store.lastrobbed) < 600 and store.lastrobbed ~= 0 then

			TriggerClientEvent('esx:showNotification', source, _U('already_robbed') .. (1800 - (os.time() - store.lastrobbed)) .. _U('seconds'))
			return
		end


		local cops = 0
		local copsoff = 0
		for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

 		  if xPlayer.job.name == 'police'then
				cops = cops + 1
			end

			if xPlayer.job.name == 'police' and xPlayer.job.grade >= 3 then
				copsoff = copsoff + 1
			end
		end


		if rob == false then

				if(cops >= Config.NumberOfCopsRequired)then
					if(copsoff >= Config.NumberOfffCopsRequired)then

						rob = true
						for i=1, #xPlayers, 1 do
							local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
							if xPlayer.job.name == 'police' then
									TriggerClientEvent('esx:showNotification', xPlayers[i], _U('rob_in_prog') .. store.nameofstore)
									TriggerClientEvent('esx_holdupstore:setblip', xPlayers[i], Stores[robb].position)
							end
						end

						local xPlayer = ESX.GetPlayerFromId(source)
						TriggerClientEvent('esx:showNotification', source, _U('started_to_rob') .. store.nameofstore .. _U('do_not_move'))
						TriggerClientEvent('esx:showNotification', source, _U('alarm_triggered'))
						TriggerClientEvent('esx:showNotification', source, _U('hold_pos'))
						TriggerClientEvent('esx_holdupstore:currentlyrobbing', source, robb)
						TriggerEvent('esx:holdupmagbot',xPlayer.name,store.nameofstore)

						Stores[robb].lastrobbed = os.time()
						robbers[source] = robb
						local savedSource = source
						SetTimeout(150000, function()

							if(robbers[savedSource])then

								rob = false
								TriggerClientEvent('esx_holdupstore:robberycomplete', savedSource, job)
								local xPlayer = ESX.GetPlayerFromId(source)
								TriggerEvent('esx:holdupmagbot3',xPlayer.name,store.nameofstore,store.reward)
								if(xPlayer)then

									xPlayer.addAccountMoney('black_money', store.reward)
									local xPlayers = ESX.GetPlayers()
									for i=1, #xPlayers, 1 do
										local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
										if xPlayer.job.name == 'police' then
												TriggerClientEvent('esx:showNotification', xPlayers[i], _U('robbery_complete_at') .. store.nameofstore)
												TriggerClientEvent('esx_holdupstore:killblip', xPlayers[i])
										end
									end
								end
							end
						end)
					else
						TriggerClientEvent('esx:showNotification', source, 'Il faut minimum '  .. Config.NumberOfffCopsRequired .. ' haut grader pour braquer la banque')
					end
			  else
				TriggerClientEvent('esx:showNotification', source, _U('min_two_police') .. Config.NumberOfCopsRequired .. ' policiers pour braquer le magasin')
			end
		else
			TriggerClientEvent('esx:showNotification', source, _U('robbery_already'))
		end
	end
end)
