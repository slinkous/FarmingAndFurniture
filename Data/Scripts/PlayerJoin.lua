local plots = script:GetCustomProperty("Plots"):WaitForObject():GetChildren()
local propPlayerSign = script:GetCustomProperty("PlayerSign")

function OnPlayerJoined(player)
	print("player joined: " .. player.name)
	for _, plot in ipairs(plots) do
		if plot:GetCustomProperty("Owner") == "" then
			plot:SetNetworkedCustomProperty("Owner", player.id)
			local signLocation = plot:GetWorldPosition()
			local sign = World.SpawnAsset(propPlayerSign, {parent = plot})
			sign:FindChildByName("Player Text").text = player.name
			return
		end
	end

end

function OnPlayerLeft(player)
	print("player left: " .. player.name)
	for _, plot in ipairs(plots) do
		if plot:GetCustomProperty("Owner") == player.id then
			plot:SetNetworkedCustomProperty("Owner", "")
			local sign = plot:FindChildByName("Player Sign")
			sign:Destroy()
			return
		end
	end
end

-- on player joined/left functions need to be defined before calling event:Connect()
Game.playerJoinedEvent:Connect(OnPlayerJoined)
Game.playerLeftEvent:Connect(OnPlayerLeft)
