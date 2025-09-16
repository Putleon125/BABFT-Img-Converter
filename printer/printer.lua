local workspace = game:GetService('Workspace')

local args = {
	"WoodBlock",
	8,
	workspace:WaitForChild("CamoZone"),
	CFrame.new(28, 6.100000381469727, -44, 1, 0, 0, 0, 1, 0, 0, 0, 1),
	true,
	CFrame.new(-372.9656677246094, -11.899991989135742, 257.8931579589844, 0, 0, 1, 0, 1, 0, -1, 0, 0),
	false
}
game:GetService("Players").LocalPlayer:WaitForChild("Backpack"):WaitForChild("BuildingTool"):WaitForChild("RF"):InvokeServer(unpack(args))

