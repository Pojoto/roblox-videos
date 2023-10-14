
local screen = script.Parent.ScreenGui
local button_frame = screen.Frame

gen_button = button_frame.GenerateButton
simple_hill_button = button_frame.SimpleHillClimbing
steepest_hill_button = button_frame.SteepestHillClimbing
stochastic_hill_button = button_frame.StochasticHillClimbing
sim_anneal_button = button_frame.SimulatedAnnealing
genetic_alg_button = button_frame.GeneticAlgorithm

generate = game:GetService("ReplicatedStorage").generate
swap = game:GetService("ReplicatedStorage").swap


local function onGenerate()
	
	generate:FireServer()
	
end


gen_button.Activated:Connect(onGenerate)

simple_hill_button.Activated:Connect(function()
	swap:FireServer("Simple")
end)

steepest_hill_button.Activated:Connect(function()
	swap:FireServer("Steepest")
end)

stochastic_hill_button.Activated:Connect(function()
	swap:FireServer("Stochastic")
end)

sim_anneal_button.Activated:Connect(function()
	swap:FireServer("Simulated")
end)

genetic_alg_button.Activated:Connect(function()
	swap:FireServer("Genetic")
end)