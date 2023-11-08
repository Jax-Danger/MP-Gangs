RegisterNetEvent('Gangs:Server:CreateGang')
AddEventHandler('Gangs:Server:CreateGang', function(GangName)
	local src = source
	local identifiers = GetPlayerIdentifiers(src)
	
	local identifier = identifiers[1]
	exports.oxmysql:execute('SELECT * FROM gangs WHERE identifier = ?', {identifier}, function(result)
		if result[1] then
			return
		else
			exports.oxmysql:insert('INSERT INTO gangs (identifier, gang_name) VALUES (?, ?)', {identifier, GangName}, function(id)
				exports.oxmysql:execute('INSERT INTO gang_members (gang_id, members, gang_name, isBoss) VALUES (?, ?, ?, ?)', {id, identifier, GangName, 1})
			end)
		end
		TriggerEvent('Gangs:Server:CurrentGang', src)
	end)
	TriggerEvent('Gangs:Server:CurrentGang', src)
end)

RegisterNetEvent('Gangs:Server:CurrentGang')
AddEventHandler('Gangs:Server:CurrentGang', function()
	local src = source
	local identifier = GetPlayerIdentifiers(src)[1]
	if identifier then
		exports.oxmysql:execute('SELECT * FROM gang_members WHERE members = ?', {identifier}, function(result)
			if result[1] then
				local CurrentGang = result[1].gang_name
				local isBoss = result[1].isBoss
				print('Current Gang: ', CurrentGang, 'isBoss: ', isBoss)
				if isBoss == 1 then
					print(isBoss)
					TriggerClientEvent('Gangs:Client:CurrentGang', src, CurrentGang, isBoss)
				elseif isBoss == 0 then
					print('boss is 0')
					TriggerClientEvent('Gangs:Client:CurrentGang', src, CurrentGang, nil)
				end
			else
				TriggerClientEvent('Gangs:Client:CurrentGang', src, nil, nil)
			end
		end)
	end
end)


-- on resource start trigger client event close all menus
AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
		return
	end
	TriggerClientEvent('Gangs:CloseAllMenus', -1)
end)


RegisterNetEvent('Gangs:Server:LeaveGang')
AddEventHandler('Gangs:Server:LeaveGang', function()
	local src = source
	local identifier = GetPlayerIdentifiers(src)[1]
	--if player identifier has isBoss 1 then delete from gang table and gang_members table
	exports.oxmysql:execute('SELECT * FROM gang_members WHERE members = ?', {identifier}, function(result)
		if result[1] then
			if result[1].isBoss == 1 then
				exports.oxmysql:execute('DELETE FROM gang_members WHERE members = ?', {identifier})
				Citizen.Wait(100)
				exports.oxmysql:execute('DELETE FROM gangs WHERE identifier = ?', {identifier})
			else
				exports.oxmysql:execute('DELETE FROM gang_members WHERE members = ?', {identifier})
			end
		end
	end)
end)
