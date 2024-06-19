function PlayerLook(Player, TargetPlayer)
    local PlayerCoords = GetEntityCoords(Player, true)
    local TargetCoords = GetEntityCoords(TargetPlayer, true)
    local PlayerHeading = GetEntityHeading(Player)
    local TargetHeading = GetHeadingFromVector_2d(TargetCoords.x - PlayerCoords.x, TargetCoords.y - PlayerCoords.y)

    local HeadingDifference = math.abs(PlayerHeading - TargetHeading)

    return HeadingDifference < 90 or HeadingDifference > 270
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local Player = PlayerPedId()

        for k, v in ipairs(GetActivePlayers()) do
            local TargetPlayer = GetPlayerPed(v)
            if TargetPlayer ~= Player then
                local IsFacing = PlayerLook(Player, TargetPlayer)

                if not IsFacing then
                    SetEntityAlpha(TargetPlayer, 100, false)
                else
                    ResetEntityAlpha(TargetPlayer)
                end
            end
        end
    end
end)