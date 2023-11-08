
RegisterNetEvent('Gangs:Client:CurrentGang')
AddEventHandler('Gangs:Client:CurrentGang', function(CurrentGang, isBoss)
	if CurrentGang ~= nil then
		CurrentGang = CurrentGang
		gang2_menu(CurrentGang)
	else
		CurrentGang = 'None'
		isBoss = '0'
		gang_menu(CurrentGang)
	end
	if isBoss == 1 and CurrentGang ~= nil then
		gang_boss_menu(CurrentGang, isBoss)
	end
end)


RegisterCommand('gangs', function()
	TriggerServerEvent('Gangs:Server:CurrentGang')
end, false)


RegisterNetEvent('Gangs:Client:CreateGangMenu')
AddEventHandler('Gangs:Client:CreateGangMenu', function()
	local input = lib.inputDialog('Create a Gang', {
		{type = 'input', label = 'Gang Name', description = 'Insert a name for your gang.', required = true, min = 3, max = 16},
	})
	local GangName = input[1]
	if GangName then
		TriggerServerEvent('Gangs:Server:CreateGang', GangName)
	end
end)



RegisterNetEvent('Gangs:CloseAllMenus')
AddEventHandler('Gangs:CloseAllMenus', function()
	lib.closeInputDialog()
end)


function gang_menu(CurrentGang)
	lib.registerContext({
		id = 'gang_menu',
		title = 'Gang menu',
		options = {
			{
				title = 'Current Gang: '..CurrentGang..'',
			},
			{
				title = 'Create a Gang',
				description = 'Open a menu from the event and send event data',
				event = 'Gangs:Client:CreateGangMenu',
			}
		}
	})	
	lib.showContext('gang_menu')
end

function gang2_menu(CurrentGang)
	lib.registerContext({
		id = 'gang2_menu',
		title = 'Gang menu',
		options = {
			{
				title = 'Current Gang: '..CurrentGang..'',
			},
			{
				title = 'Leave Gang',
				description = 'Leave your current gang.',
				event = 'Gangs:Client:LeaveGang',
			}
		}
	})	
	lib.showContext('gang2_menu')
end
function gang_boss_menu(CurrentGang, isBoss)
	lib.registerContext({
		id = 'gang_boss_menu',
		title = 'Gang menu',
		options = {
			{
				title = 'Your Gang: '..CurrentGang..'',
			},
			{
				title = 'Manage Gang Members',
				description = 'Manage the members in your gang.',
				event = 'Gangs:Client:ManageGangMembers',
			},
			{
				title = 'Disband your Gang',
				description = 'Disband your current gang.',
				event = 'Gangs:Client:LeaveGang',
			}
		}
	})	
	lib.showContext('gang_boss_menu')
end

RegisterNetEvent('Gangs:Client:LeaveGang')
AddEventHandler('Gangs:Client:LeaveGang', function()
	TriggerServerEvent('Gangs:Server:LeaveGang')
end)