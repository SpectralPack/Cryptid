-- d20.lua - APIs for D20 content

-- Currently this is very empty since D20 hasn't been fully implemented yet, but it should have a lot more later.

--Will be moved to D20 file when that gets added
function roll(dice, seed, config)
    if not config then
        config = {}
    end
    if type(dice.amount) == "table" then
        return roll({
            amount = roll(dice.amount, seed, config),
            sides = dice.sides
        }, seed, config)
    else
        if type(dice.sides) == "table" then
            return roll({
                amount = dice.amount,
                sides = roll(dice.sides, seed, config)
            },
            seed,
            config)
        else
            if dice.amount <= 0 then
                return 0
            end
            local total = 0
            for i = 1, dice.amount do
                local add = math.min(1 + math.floor(pseudorandom(seed) * (dice.sides)), dice.sides)
                if config.singularitus and (add == dice.sides) then
                    total = total + 2 * add
                else
                    total = total + add
                end
            end
            return total
        end
    end
end