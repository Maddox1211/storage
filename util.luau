-- Script Path: game:GetService("ReplicatedStorage").Modules.Util
-- Took 0.32s to decompile.
-- Executor: Volt (1.3.15.1)

local tbl_upv_1 = {}
local TweenService_upv_1 = game:GetService("TweenService")
local RunService_upv_1 = game:GetService("RunService")
local CollectionService_upv_1 = game:GetService("CollectionService")
local TextService_upv_1 = game:GetService("TextService")
local StarterGui_1 = game:GetService("StarterGui")
local LogService_upv_1 = game:GetService("LogService")
local CancellingFunction_1 = require(script.CancellingFunction)
local DebouncingFunction_1 = require(script.DebouncingFunction)
local BufferingFunction_upv_1 = require(script.BufferingFunction)
local CachingFunction_1 = require(script.CachingFunction)
if RunService_upv_1:IsClient() then
    player = game.Players.LocalPlayer
    StarterGui_1:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
    StarterGui_1:SetCoreGuiEnabled(Enum.CoreGuiType.Health, false)
    StarterGui_1:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
end
function tbl_upv_1.closest_point_on_segment(a1, a2, a3)
    --[[
      name: closest_point_on_segment
      line: 20
    ]]
    local v1 = a3 - a2
    local v2 = v1:Dot(v1)
    if v2 ~= 0 then
        return a2 + (v1 * math.max(0, math.min(1, (a1 - a2):Dot(v1) / v2)))
    end
    return a2
end
function tbl_upv_1.get_point_to_part_info(a1, a2)
    --[[
      name: get_point_to_part_info
      line: 36
    ]]
    local v3 = a2.CFrame:PointToWorldSpace(a2.CFrame:PointToObjectSpace(a1):Clamp(-a2.Size / 2, a2.Size / 2))
    local v4 = a1 - a2.Position
    local v5 = Vector3.new(math.abs(v4.X / (a2.Size.X / 2)), math.abs(v4.Y / (a2.Size.Y / 2)), math.abs(v4.Z / (a2.Size.Z / 2)))
    local v6 = nil
    local v7 = -math.huge
    if v7 < v5.X then
        v7, v6 = v5.X, Vector3.new(1, 0, 0)
    end
    if v7 < v5.Y then
        v7, v6 = v5.Y, Vector3.new(0, 1, 0)
    end
    if v7 < v5.Z then
        v6 = Vector3.new(0, 0, 1)
    end
    return v3, (a2.CFrame:VectorToWorldSpace(Vector3.new(v6.X * math.sign(v4.X), v6.Y * math.sign(v4.Y), v6.Z * math.sign(v4.Z))))
end
function tbl_upv_1.map_log(a1, a2, a3, a4, a5)
    --[[
      name: map_log
      line: 61
    ]]
    return (math.log10((((a1 - a2) / (a3 - a2)) * 9.5) + 0.5) * (a5 - a4)) + a4
end
function tbl_upv_1.map_sensitivity(a1)
    --[[
      name: map_sensitivity
      line: 67
    ]]
    return math.exp((0.04651687056553628 * (a1 - 1)) + 0.023258435282768275) * 0.1
end
function tbl_upv_1.clamp_deadzone(a1, a2)
    --[[
      name: clamp_deadzone
      line: 78
    ]]
    a2 = a2 or 0.05
    local X_1 = a1.X
    local Y_1 = a1.Y
    local Z_1 = a1.Z
    local v8 = ((math.abs(X_1) <= a2) and 0) or X_1
    local v9 = ((math.abs(Y_1) <= a2) and 0) or Y_1
    return (Vector3.new(v8, v9, Z_1))
end
function tbl_upv_1.warn(a1, a2)
    --[[
      name: warn
      line: 88
      upvalues:
        LogService_upv_1 (copy, index: 1)
    ]]
    LogService_upv_1:Warn(a1, a2)
end
function tbl_upv_1.get_kd(a1, a2)
    --[[
      name: get_kd
      line: 92
    ]]
    if a2 ~= nil and not (a2 <= 1) then
        return math.floor(((a1 / a2) * 10) + 0.5) / 10
    end
    return (("%*.0"):format(math.max(1, math.round(a1 or 0))))
end
function tbl_upv_1.get_weighted_kd(a1)
    --[[
      name: get_weighted_kd
      line: 99
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    if not a1 or #a1 == 0 then
        return "1.0"
    end
    local v10 = 0
    local v11 = 0
    local v12, v13 = nil, nil
    for _, value_1 in ipairs(a1) do
        v12 = value_1[1] or 0
        v13 = value_1[2] or 0
        local v14 = math.clamp(value_1[3] or 1, 0, 1)
        if v13 < v12 then
            v12 = math.lerp(v12, v13, 1 - v14)
            v10 = v10 + v12
            v11 = v11 + v13
            continue
        end
        if v12 < v13 then
            v13 = math.lerp(v13, v12, 1 - v14)
        end
        v10 = v10 + v12
        v11 = v11 + v13
    end
    return tbl_upv_1.get_kd(v10, v11)
end
function tbl_upv_1.os_time()
    --[[
      name: os_time
      line: 125
      upvalues:
        RunService_upv_1 (copy, index: 1)
    ]]
    if game.Workspace:GetAttribute("frozen_time") then
        return game.Workspace:GetAttribute("frozen_time")
    elseif RunService_upv_1:IsClient() then
        return (math.floor(workspace:GetServerTimeNow()))
    else
        return os.time()
    end
end
function tbl_upv_1.apply_offsets(a1, a2)
    --[[
      name: apply_offsets
      line: 137
    ]]
    local v15 = CFrame.new(a1.Position)
    for _, value_2 in a2 do
        v15 = v15 * value_2
    end
    return v15 * a1.Rotation
end
function tbl_upv_1.get_rank_from_mmr(a1)
    --[[
      name: get_rank_from_mmr
      line: 145
    ]]
    if a1 <= 0 then
        return 0, 0, 1
    end
    local v16 = 1
    local v17 = nil
    while true do
        v17 = v16 * 100
        if a1 < v17 then
            break
        end
        v16 = v16 + 1
    end
    if v16 >= 16 then
        return 16, 0, 0
    end
    return v16, (v16 - 1) * 100, v17
end
function tbl_upv_1.get_level_from_xp(a1)
    --[[
      name: get_level_from_xp
      line: 164
    ]]
    local v18 = 1
    local v19 = nil
    while true do
        v19 = v18 * 10 * v18
        if a1 < v19 then
            break
        end
        v18 = v18 + 1
    end
    return v18, ((v18 - 1) * 10) * (v18 - 1), v19
end
function tbl_upv_1.is_assembly_anchored(a1)
    --[[
      name: is_assembly_anchored
      line: 185
    ]]
    if a1:IsA("Model") then
        for _, value_3 in a1:GetChildren() do
            if not (value_3:IsA("BasePart")) or not (value_3.Anchored) then
                continue
            end
            return true
        end
    elseif a1:IsA("BasePart") then
        for _, value_4 in a1:GetConnectedParts() do
            if not (value_4.Anchored) then
                continue
            end
            return true
        end
    end
    return false
end
function tbl_upv_1.look_at_with_stable_roll(a1, a2, a3, a4)
    --[[
      name: look_at_with_stable_roll
      line: 202
    ]]
    local unit_1 = (a2 - a1).unit
    local unit_2 = unit_1:Cross(a3).unit
    local v20 = CFrame.fromMatrix(a1, unit_2, unit_2:Cross(unit_1), -unit_1)
    local v21 = ((unit_2:Dot(a4) < -0.99) and (v20 * CFrame.Angles(0, 0, math.pi))) or v20
    return v21 * CFrame.Angles(0, 0, 1.5707963267948966)
end
function tbl_upv_1.get_xy_offset(a1, a2)
    --[[
      name: get_xy_offset
      line: 219
    ]]
    local v22 = a2.Position - a1.Position
    return v22:Dot(a1.RightVector), (v22:Dot(a1.UpVector))
end
function tbl_upv_1.get_closest_point_on_box(a1, a2, a3)
    --[[
      name: get_closest_point_on_box
      line: 229
    ]]
    local v23 = a2:pointToObjectSpace(a1)
    local v24 = a3 * 0.5
    return a2:pointToWorldSpace(Vector3.new(math.clamp(v23.X, -v24.X, v24.X), math.clamp(v23.Y, -v24.Y, v24.Y), math.clamp(v23.Z, -v24.Z, v24.Z)))
end
function tbl_upv_1.get_closest_point_on_part(a1, a2)
    --[[
      name: get_closest_point_on_part
      line: 242
    ]]
    return a2:GetClosestPointOnSurface(a1)
end
function tbl_upv_1.get_point_to_box_distance(a1, a2, a3)
    --[[
      name: get_point_to_box_distance
      line: 246
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    return (a1 - tbl_upv_1.get_closest_point_on_box(a1, a2, a3)).Magnitude
end
function tbl_upv_1.get_point_to_part_distance(a1, a2)
    --[[
      name: get_point_to_part_distance
      line: 251
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    return (a1 - tbl_upv_1.get_closest_point_on_part(a1, a2)).Magnitude
end
function tbl_upv_1.adjust_reach(a1, a2, a3)
    --[[
      name: adjust_reach
      line: 256
    ]]
    local v25 = a2 - a1
    local Magnitude_1 = v25.Magnitude
    if a3 < Magnitude_1 then
        return a1 + (v25.Unit * (Magnitude_1 - a3))
    end
    return a1
end
function tbl_upv_1.ownership(a1, a2)
    --[[
      name: ownership
      line: 270
    ]]
    local v26 = a2 or player
    if a1 and v26 then
        if a1:GetAttribute("UserId") ~= v26:GetAttribute("UserId") then
            if v26:GetAttribute("Spectator") or a1:GetAttribute("Team") and a1:GetAttribute("Team") == v26:GetAttribute("Team") then
                return 2
            end
            return 0
        end
        return 3
    end
    return 1
end
function tbl_upv_1.clamp_look_vector(a1, a2, a3)
    --[[
      name: clamp_look_vector
      line: 281
    ]]
    local v27 = math.rad(a3)
    local Unit_1 = a1.Unit
    local Unit_2 = a2.Unit
    if math.acos(math.clamp(Unit_1:Dot(Unit_2), -1, 1)) <= v27 then
        return Unit_2
    end
    local Unit_3 = Unit_1:Cross(Unit_2).Unit
    if Unit_3.Magnitude == 0 then
        return Unit_1
    end
    local v28 = math.cos(v27)
    local v29 = math.sin(v27)
    return ((Unit_1 * v28) + (Unit_3:Cross(Unit_1) * v29) + (Unit_3 * (Unit_3:Dot(Unit_1) * (1 - v28)))).Unit
end
function tbl_upv_1.is_facing_point(a1, a2, a3)
    --[[
      name: is_facing_point
      line: 314
    ]]
    local v30 = math.cos(math.rad(a3 or 5))
    local Position_1 = a1.Position
    local v31 = v30 <= a1.LookVector:Dot((((a2 - Position_1).Magnitude > 0) and ((a2 - Position_1).Unit)) or Vector3.new(0, 0, 0))
    return v31
end
function tbl_upv_1.is_point_inside_plane(a1, a2, a3, a4)
    --[[
      name: is_point_inside_plane
      line: 422
    ]]
    a4 = a4 or 0.1
    local v32 = a2:PointToObjectSpace(a1)
    local v33 = (math.abs(v32.X) <= (a3.X * 0.5) + a4) and (math.abs(v32.Z) <= (a3.Z * 0.5) + a4)
    return v33
end
function tbl_upv_1.is_point_inside_part(a1, a2, a3)
    --[[
      name: is_point_inside_part
      line: 429
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    a3 = a3 or 0.1
    if a2:IsA("Model") then
        local v34, v35 = a2:GetBoundingBox()
        local v36 = (a1 - tbl_upv_1.get_closest_point_on_box(a1, v34, v35)).Magnitude < a3
        return v36
    else
        local v37 = (a1 - tbl_upv_1.get_closest_point_on_part(a1, a2)).Magnitude < a3
        return v37
    end
end
function tbl_upv_1.get_zone_is_in(a1)
    --[[
      name: get_zone_is_in
      line: 476
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v38 = game.Workspace:FindFirstChild("SoundZones", true)
    if v38 == nil then
        return
    end
    local v39 = OverlapParams.new()
    v39.MaxParts = 3
    v39.FilterType = Enum.RaycastFilterType.Include
    v39.FilterDescendantsInstances = {v38}
    local v40 = math.huge
    local v41 = nil
    for _, value_5 in workspace:GetPartBoundsInRadius(a1, 0.1, v39) do
        local v42 = tbl_upv_1.is_point_inside_part(a1, value_5, 0.1)
        if not (v42) then
            continue
        end
        local v43 = tbl_upv_1.get_point_to_part_distance(a1, value_5)
        if v43 < v40 or v43 + v40 < 0.01 and value_5.Size.Magnitude < v41.Size.Magnitude then
            v40, v41 = v43, value_5
        end
    end
    return v41 and (v41.Parent)
end
function normalize_angle(a1)
    --[[
      name: normalize_angle
      line: 498
    ]]
    return ((a1 + 180) % 360) - 180
end
function tbl_upv_1.angles_within_range(a1, a2, a3)
    --[[
      name: angles_within_range
      line: 502
    ]]
    local v44 = math.abs(normalize_angle(a1 - a2)) <= a3
    return v44
end
function tbl_upv_1.clampAngle(a1, a2, a3)
    --[[
      name: clampAngle
      line: 507
    ]]
    if a1 < a2 then
        return a2
    elseif a3 < a1 then
        return a3
    else
        return a1
    end
end
function tbl_upv_1.clampCFrameRotation(a1, a2, a3)
    --[[
      name: clampCFrameRotation
      line: 517
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v45, v46, v47 = a2:ToOrientation()
    local v48, v49, v50 = a1:ToOrientation()
    local v51 = tbl_upv_1.clampAngle(v48, v45 - a3, v45 + a3)
    local v52 = tbl_upv_1.clampAngle(v49, v46 - a3, v46 + a3)
    local v53 = tbl_upv_1.clampAngle(v50, v47 - a3, v47 + a3)
    return CFrame.new(a1.Position) * CFrame.Angles(v51, v52, v53)
end
function tbl_upv_1.clip_angle(a1, a2, a3, a4)
    --[[
      name: clip_angle
      line: 531
    ]]
    a1 = normalize_angle(a1)
    a2 = normalize_angle(a2)
    local v54 = normalize_angle(a2 + a3)
    local v55 = normalize_angle(a2 + a4)
    if v54 <= v55 then
        if a1 < v54 then
            return v54
        end
        if v55 < a1 then
            return v55
        end
    elseif not (v54 <= a1) and not (a1 <= v55) then
        if math.abs(a1 - v54) < math.abs(a1 - v55) then
            return v54
        end
        return v55
    end
    return a1
end
function tbl_upv_1.angle_distance_and_direction(a1, a2)
    --[[
      name: angle_distance_and_direction
      line: 559
    ]]
    local v56 = math.abs(a2 - a1) % math.tau
    local v57 = ((a2 < a1) and -1) or 1
    if v56 > math.pi then
        v56 = math.tau - v56
        v57 = -v57
    end
    return v56, v57
end
function tbl_upv_1.center_pivot(a1)
    --[[
      name: center_pivot
      line: 572
    ]]
    local v58 = a1:GetPivot()
    a1.PrimaryPart = nil
    a1.WorldPivot = CFrame.new(a1:GetBoundingBox().Position) * v58.Rotation
    a1:PivotTo(v58)
end
function tbl_upv_1.center_pivot_longitude(a1)
    --[[
      name: center_pivot_longitude
      line: 580
    ]]
    local v59 = a1:GetPivot()
    a1.PrimaryPart = nil
    local v60 = a1:GetBoundingBox()
    a1.WorldPivot = CFrame.new(v60.Position.X, v59.Position.Y, v60.Position.Z) * v59.Rotation
    a1:PivotTo(v59)
end
local u1 = Random.new()
function tbl_upv_1.rand(a1, a2, a3)
    --[[
      name: rand
      line: 594
      upvalues:
        u1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    if typeof(a1) == "number" then
        local v61 = (a3 and (u1:NextInteger(a1, a2))) or (u1:NextNumber(a1, a2))
        return v61
    elseif typeof(a1) == "Vector3" then
        return (Vector3.new(tbl_upv_1.rand(a1.X, a2.X, a3), tbl_upv_1.rand(a1.Y, a2.Y, a3), tbl_upv_1.rand(a1.Z, a2.Z, a3)))
    end
end
function tbl_upv_1.weighted_random(a1, a2)
    --[[
      name: weighted_random
      line: 606
    ]]
    local v62 = 0
    for _, value_6 in a1 do
        v62 = v62 + value_6
    end
    local v63
    if a2 then
        v63 = a2:NextNumber() * v62
    else
        math.random()
        math.random()
        math.random()
        math.random()
        math.random()
        v63 = math.random() * v62
    end
    local v64 = 0
    for key_1, value_7 in a1 do
        v64 = v64 + value_7
        if not (v63 <= v64) then
            continue
        end
        return key_1
    end
end
function tbl_upv_1.weld(a1, a2)
    --[[
      name: weld
      line: 630
    ]]
    local v65 = Instance.new("Weld", a1)
    v65.Part0 = a1
    v65.Part1 = a2
    a1.Anchored = false
    return v65
end
function tbl_upv_1.weld_c(a1, a2)
    --[[
      name: weld_c
      line: 638
    ]]
    local v66 = Instance.new("WeldConstraint", a1)
    v66.Part0 = a1
    v66.Part1 = a2
    a1.Anchored = false
    return v66
end
function tbl_upv_1.weld_model(a1)
    --[[
      name: weld_model
      line: 646
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local PrimaryPart_1 = a1.PrimaryPart
    if PrimaryPart_1 == nil then
        warn(a1, "does not have a Primary Part")
    end
    for _, value_8 in a1:GetDescendants() do
        if not (value_8:IsA("BasePart")) or value_8 == PrimaryPart_1 then
            continue
        end
        if value_8.Anchored then
            value_8.Anchored = false
            tbl_upv_1.weld_c(value_8, PrimaryPart_1)
        end
    end
end
function tbl_upv_1.render(a1, a2)
    --[[
      name: render
      line: 659
      upvalues:
        RunService_upv_1 (copy, index: 1)
    ]]
    local v67 = RunService_upv_1.RenderStepped:Connect(
        function()
            --[[
              line: 660
              upvalues:
                a2 (copy, index: 1)
            ]]
            a2()
        end
    )
    task.wait(a1)
    v67:Disconnect()
end
function tbl_upv_1.run_pre(a1)
    --[[
      name: run_pre
      line: 667
      upvalues:
        RunService_upv_1 (copy, index: 1)
    ]]
    return (RunService_upv_1.PreSimulation:Connect(
        function(a2)
            --[[
              line: 668
              upvalues:
                a1 (copy, index: 1)
            ]]
            a1(a2)
        end
    ))
end
function tbl_upv_1.run_post(a1)
    --[[
      name: run_post
      line: 674
      upvalues:
        RunService_upv_1 (copy, index: 1)
    ]]
    return (RunService_upv_1.PreRender:Connect(
        function(a2)
            --[[
              line: 675
              upvalues:
                a1 (copy, index: 1)
            ]]
            a1(a2)
        end
    ))
end
function tbl_upv_1.bind_render_step(a1, a2, a3)
    --[[
      name: bind_render_step
      line: 681
      upvalues:
        RunService_upv_1 (copy, index: 1)
    ]]
    RunService_upv_1:BindToRenderStep(a1, a2, a3)
end
function tbl_upv_1.unbind_render_step(a1)
    --[[
      name: unbind_render_step
      line: 685
      upvalues:
        RunService_upv_1 (copy, index: 1)
    ]]
    RunService_upv_1:UnbindFromRenderStep(a1)
end
local tbl_upv_2 = {}
function tbl_upv_1.get_cached(a1)
    --[[
      name: get_cached
      line: 691
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    if tbl_upv_2[a1] then
        return tbl_upv_2[a1]
    end
end
function tbl_upv_1.set_cached(a1, a2)
    --[[
      name: set_cached
      line: 695
      upvalues:
        tbl_upv_2 (copy, index: 1)
    ]]
    if tbl_upv_2[a1] == nil then
        a1.Destroying:Connect(
            function()
                --[[
                  line: 697
                  upvalues:
                    tbl_upv_2 (copy, index: 1)
                    a1 (copy, index: 2)
                ]]
                tbl_upv_2[a1] = nil
            end
        )
    end
    tbl_upv_2[a1] = a2
end
tbl_upv_1.run = tbl_upv_1.run_post
function tbl_upv_1.clock()
    --[[
      name: clock
      line: 706
    ]]
    return workspace:GetServerTimeNow() - 1.7e+09
end
function tbl_upv_1.lerp(a1, a2, a3)
    --[[
      name: lerp
      line: 710
    ]]
    if typeof(a1) ~= "number" then
        return a1:Lerp(a2, a3)
    end
    return a1 + (a3 * (a2 - a1))
end
function tbl_upv_1.cubic_blerp(a1, a2, a3, a4, a5)
    --[[
      name: cubic_blerp
      line: 718
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v68 = tbl_upv_1.lerp(a1, a2, a5)
    local v69 = tbl_upv_1.lerp(a2, a3, a5)
    local v70 = tbl_upv_1.lerp(a3, a4, a5)
    return (tbl_upv_1.lerp(tbl_upv_1.lerp(v68, v69, a5), tbl_upv_1.lerp(v69, v70, a5), a5))
end
function tbl_upv_1.quad_blerp(a1, a2, a3, a4)
    --[[
      name: quad_blerp
      line: 730
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    return (tbl_upv_1.lerp(tbl_upv_1.lerp(a1, a2, a4), tbl_upv_1.lerp(a2, a3, a4), a4))
end
function tbl_upv_1.ease_in_out_expo(a1)
    --[[
      name: ease_in_out_expo
      line: 738
    ]]
    if a1 ~= 0 and a1 ~= 1 then
        if a1 < 0.5 then
            return math.pow(2, (a1 * 20) - 10) / 2
        end
        return (2 - math.pow(2, (a1 * -20) + 10)) / 2
    end
    return a1
end
tbl_upv_1.db = DebouncingFunction_1.db
tbl_upv_1.gdb = DebouncingFunction_1.gdb
tbl_upv_1.is_gdb_debounced = DebouncingFunction_1.is_gdb_debounced
tbl_upv_1.ov = CancellingFunction_1.ov
tbl_upv_1.bf = BufferingFunction_upv_1.bf
tbl_upv_1.cf = CachingFunction_1.cf
function tbl_upv_1.is_moving_forward_or_backward(a1, a2)
    --[[
      name: is_moving_forward_or_backward
      line: 766
    ]]
    local v71 = math.deg(math.acos(math.clamp(a1:Dot(a2), -1, 1)))
    if v71 <= 60 then
        return 1
    elseif v71 >= 120 then
        return -1
    else
        return 0
    end
end
function tbl_upv_1.move_angle(a1, a2)
    --[[
      name: move_angle
      line: 777
    ]]
    return (math.deg(math.acos(math.clamp(a1:Dot(a2), -1, 1))))
end
function tbl_upv_1.get_look_vector_angle(a1, a2)
    --[[
      name: get_look_vector_angle
      line: 781
    ]]
    local Unit_4 = a1.Unit
    local Unit_5 = a2.Unit
    return (math.deg(math.atan2((Unit_4.X * Unit_5.Z) - (Unit_4.Z * Unit_5.X), Unit_4:Dot(Unit_5))))
end
function tbl_upv_1.get_move_components(a1, a2)
    --[[
      name: get_move_components
      line: 790
    ]]
    local Unit_6 = Vector3.new(-a2.Z, 0, a2.X).Unit
    local Unit_7 = Vector3.new(a2.X, 0, a2.Z).Unit
    return math.clamp(a1:Dot(Unit_6), -1, 1), (math.clamp(a1:Dot(Unit_7), -1, 1))
end
function tbl_upv_1.normal_to_face(a1, a2)
    --[[
      name: normal_to_face
      line: 802
    ]]
    for _, value_9 in pairs({Enum.NormalId.Front, Enum.NormalId.Back, Enum.NormalId.Bottom, Enum.NormalId.Top, Enum.NormalId.Left, Enum.NormalId.Right}) do
        if not (GetNormalFromFace(a2, value_9):Dot(a1) > 0.999) then
            continue
        end
        return value_9
    end
    return nil
end
function GetNormalFromFace(a1, a2)
    --[[
      name: GetNormalFromFace
      line: 824
    ]]
    return a1.CFrame:VectorToWorldSpace(Vector3.FromNormalId(a2))
end
function tbl_upv_1.get(a1, a2, a3)
    --[[
      name: get
      line: 828
    ]]
    a3 = a3 or 60
    local v72 = os.clock()
    while a1[a2] == nil do
        task.wait()
        if a3 == nil then
            continue
        end
        if a3 < os.clock() - v72 then
            break
        end
    end
    return a1[a2]
end
function tbl_upv_1.base_tween(a1, a2, a3)
    --[[
      name: base_tween
      line: 840
      upvalues:
        TweenService_upv_1 (copy, index: 1)
    ]]
    local v73 = TweenService_upv_1:Create(a1, a2, a3)
    v73:Play()
    return v73
end
local tbl_upv_3 = {}
function tbl_upv_1.tween(a1, a2, a3)
    --[[
      name: tween
      line: 848
      upvalues:
        tbl_upv_3 (copy, index: 1)
        TweenService_upv_1 (copy, index: 2)
    ]]
    if tbl_upv_3[a1] then
        tbl_upv_3[a1]:Cancel()
        tbl_upv_3[a1] = nil
    end
    local u2 = TweenService_upv_1:Create(a1, a2, a3)
    u2:Play()
    tbl_upv_3[a1] = u2
    u2.Completed:Once(
        function()
            --[[
              line: 856
              upvalues:
                tbl_upv_3 (copy, index: 1)
                a1 (copy, index: 2)
                u2 (copy, index: 3)
            ]]
            if tbl_upv_3[a1] ~= u2 then
                return
            end
            tbl_upv_3[a1] = nil
        end
    )
    return u2
end
function tbl_upv_1.quad_tween(a1, a2, a3, a4)
    --[[
      name: quad_tween
      line: 864
      upvalues:
        tbl_upv_3 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        TweenService_upv_1 (copy, index: 3)
    ]]
    if tbl_upv_3[a1] then
        tbl_upv_3[a1]:Cancel()
        tbl_upv_3[a1] = nil
    end
    local tbl_upv_4 = {}
    for key_2, _ in a3 do
        tbl_upv_4[key_2] = a1[key_2]
    end
    local u3 = Instance.new("NumberValue")
    u3.Changed:Connect(
        function(a5)
            --[[
              line: 874
              upvalues:
                a3 (copy, index: 1)
                a1 (copy, index: 2)
                tbl_upv_1 (copy, index: 3)
                tbl_upv_4 (copy, index: 4)
                a4 (copy, index: 5)
            ]]
            for key_3, _ in a3 do
                a1[key_3] = tbl_upv_1.quad_blerp(tbl_upv_4[key_3], a3[key_3], a4[key_3], a5)
            end
        end
    )
    local u4 = TweenService_upv_1:Create(u3, a2, {Value = 1})
    u4:Play()
    tbl_upv_3[a1] = u4
    u4.Completed:Once(
        function()
            --[[
              line: 882
              upvalues:
                tbl_upv_3 (copy, index: 1)
                a1 (copy, index: 2)
                u4 (copy, index: 3)
                u3 (copy, index: 4)
            ]]
            if tbl_upv_3[a1] == u4 then
                tbl_upv_3[a1] = nil
            end
            u3:Destroy()
        end
    )
    return u4
end
function tbl_upv_1.seconds_to_legible_time(a1)
    --[[
      name: seconds_to_legible_time
      line: 891
    ]]
    if a1 < 60 then
        if a1 ~= 1 then
            return (("%* seconds"):format(a1))
        end
        return (("%* second"):format(a1))
    else
        local v74 = nil
        if a1 < 3600 then
            v74 = math.floor(a1 / 60)
            if v74 ~= 1 then
                return (("%* minutes"):format(v74))
            end
            return (("%* minute"):format(v74))
        else
            local v75, v76 = nil, nil
            if a1 < 86400 then
                v76 = math.floor(a1 / 3600)
                if v76 ~= 1 then
                    return (("%* hours"):format(v76))
                end
                return (("%* hour"):format(v76))
            end
            v75 = math.floor(a1 / 86400)
            if v75 ~= 1 then
                return (("%* days"):format(v75))
            end
            return (("%* day"):format(v75))
        end
    end
end
function tbl_upv_1.seconds_to_time_full(a1)
    --[[
      name: seconds_to_time_full
      line: 922
    ]]
    local v77 = math.floor(a1 / 3600)
    a1 = a1 - v77 * 3600
    local v78 = math.floor(a1 / 60)
    a1 = a1 - v78 * 60
    local v79 = (v77 < 10) and ("0" .. v77) or v77
    local v80 = ":"
    local v81 = (v78 < 10) and ("0" .. v78) or v78
    local v82 = ":"
    local v83
    if a1 < 10 then
        v83 = "0" .. a1 or a1
    else
        v83 = a1
    end
    return v79 .. v80 .. v81 .. v82 .. v83
end
function tbl_upv_1.time_ago(a1)
    --[[
      name: time_ago
      line: 931
    ]]
    local v84 = os.time() - a1
    if v84 < 0 or v84 < 1 then
        return "just now"
    elseif v84 < 60 then
        return string.format("%d second%s ago", v84, ((v84 == 1) and "") or "s")
    elseif v84 < 3600 then
        local v85 = math.floor(v84 / 60)
        return string.format("%d minute%s ago", v85, ((v85 == 1) and "") or "s")
    elseif v84 < 86400 then
        local v86 = math.floor(v84 / 3600)
        return string.format("%d hour%s ago", v86, ((v86 == 1) and "") or "s")
    elseif v84 < 604800 then
        local v87 = math.floor(v84 / 86400)
        return string.format("%d day%s ago", v87, ((v87 == 1) and "") or "s")
    else
        local v88 = os.date("*t", a1)
        return string.format("%04d-%02d-%02d %02d:%02d", v88.year, v88.month, v88.day, v88.hour, v88.min)
    end
end
function tbl_upv_1.get_adjacent(a1, a2, a3)
    --[[
      name: get_adjacent
      line: 959
    ]]
    a3 = a3 or 0.1
    if a2 == nil then
        local v89 = OverlapParams.new()
        v89.RespectCanCollide = true
        v89.FilterType = Enum.RaycastFilterType.Exclude
        v89.FilterDescendantsInstances = {a1}
        a2 = v89
    end
    if a1:IsA("BasePart") then
        return game.Workspace:GetPartBoundsInBox(a1.CFrame, a1.Size + (Vector3.new(1, 1, 1) * a3), a2)
    end
    if a1:IsA("Model") then
        local v90, v91 = a1:GetBoundingBox()
        return game.Workspace:GetPartBoundsInBox(v90, v91 + (Vector3.new(1, 1, 1) * a3), a2)
    end
    error("Not supported part type")
end
local tbl_upv_5 = {}
local tbl_upv_6 = {}
function tbl_upv_6.add_item(a1, a2)
    --[[
      name: add_item
      line: 982
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    table.insert(a1.items, a2)
    if a1.destroy_time then
        tbl_upv_1.debris(a2, a1.destroy_time)
    end
    a2.Destroying:Connect(
        function()
            --[[
              line: 987
              upvalues:
                a1 (copy, index: 1)
                a2 (copy, index: 2)
            ]]
            local v92 = table.find(a1.items, a2)
            if not v92 then
                return
            end
            table.remove(a1.items, v92)
        end
    )
    while a1.max < #a1.items do
        table.remove(a1.items, 1)
        a1.items[1]:Destroy()
    end
end
function tbl_upv_1.create_debris_queue(a1, a2, a3)
    --[[
      name: create_debris_queue
      line: 1000
      upvalues:
        tbl_upv_6 (copy, index: 1)
        tbl_upv_5 (copy, index: 2)
    ]]
    local v93 = setmetatable({destroy_time = a3, items = {}, max = a2}, {__index = tbl_upv_6})
    tbl_upv_5[a1] = v93
    if typeof(a1) == "Instance" then
        a1.Destroying:Connect(
            function()
                --[[
                  line: 1010
                  upvalues:
                    tbl_upv_5 (copy, index: 1)
                    a1 (copy, index: 2)
                ]]
                tbl_upv_5[a1] = nil
            end
        )
    end
    return v93
end
function tbl_upv_1.get_closest_tagged_instance(a1, a2)
    --[[
      name: get_closest_tagged_instance
      line: 1017
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v94 = nil
    local v95 = math.huge
    for _, value_10 in tbl_upv_1.get_tagged(a2) do
        local Magnitude_2 = (value_10:GetPivot().Position - a1).Magnitude
        if Magnitude_2 < v95 then
            v95, v94 = Magnitude_2, value_10
        end
    end
    return v94
end
function tbl_upv_1.debris_queue(a1, a2, a3)
    --[[
      name: debris_queue
      line: 1029
      upvalues:
        tbl_upv_5 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    if a1 == nil then
        return nil
    end
    local v96 = tbl_upv_5[a1] or (tbl_upv_1.create_debris_queue(a1, a2, a3))
    return v96
end
function tbl_upv_1.get_tagged(a1)
    --[[
      name: get_tagged
      line: 1034
      upvalues:
        CollectionService_upv_1 (copy, index: 1)
    ]]
    return CollectionService_upv_1:GetTagged(a1)
end
if RunService_upv_1:IsClient() then
    function tbl_upv_1.hook_tagged(a1, a2)
        --[[
          name: hook_tagged
          line: 1039
          upvalues:
            CollectionService_upv_1 (copy, index: 1)
        ]]
        for _, value_11 in CollectionService_upv_1:GetTagged(a1) do
            task.spawn(a2, value_11)
        end
        return CollectionService_upv_1:GetInstanceAddedSignal(a1):Connect(
            function(a3)
                --[[
                  line: 1043
                  upvalues:
                    a2 (copy, index: 1)
                ]]
                a2(a3)
            end
        )
    end
else
    local tbl_upv_7 = {}
    RunService_upv_1.Heartbeat:Connect(
        function(a1)
            --[[
              line: 1051
              upvalues:
                tbl_upv_7 (copy, index: 1)
            ]]
            for _ = 1, 100 do
                local v97 = table.remove(tbl_upv_7, 1)
                if not (v97) then
                    break
                end
                if v97[2].Parent == nil then
                    continue
                end
                local v98 = v97[2]:IsDescendantOf(game.ServerStorage)
                if not (v98) then
                    v97[1](v97[2])
                end
            end
        end
    )
    function tbl_upv_1.hook_tagged(a1, a2)
        --[[
          name: hook_tagged
          line: 1060
          upvalues:
            CollectionService_upv_1 (copy, index: 1)
            tbl_upv_7 (copy, index: 2)
        ]]
        for _, value_12 in CollectionService_upv_1:GetTagged(a1) do
            table.insert(tbl_upv_7, {a2, value_12})
        end
        return CollectionService_upv_1:GetInstanceAddedSignal(a1):Connect(
            function(a3)
                --[[
                  line: 1064
                  upvalues:
                    tbl_upv_7 (copy, index: 1)
                    a2 (copy, index: 2)
                ]]
                table.insert(tbl_upv_7, {a2, a3})
            end
        )
    end
end
function tbl_upv_1.is_testing_place()
    --[[
      name: is_testing_place
      line: 1070
    ]]
    return game.GameId == 8473504591
end
function tbl_upv_1.is_studio()
    --[[
      name: is_studio
      line: 1074
      upvalues:
        RunService_upv_1 (copy, index: 1)
    ]]
    return RunService_upv_1:IsStudio()
end
function tbl_upv_1.debris(a1, a2)
    --[[
      name: debris
      line: 1078
    ]]
    if a1:IsA("BasePart") then
        a1.CastShadow = false
        a1.CanQuery = false
    end
    task.delay(
        a2,
        function()
            --[[
              line: 1084
              upvalues:
                a1 (copy, index: 1)
            ]]
            a1:Destroy()
        end
    )
end
function tbl_upv_1.is_utf8_compatible(a1)
    --[[
      name: is_utf8_compatible
      line: 1089
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local ty_1 = typeof(a1)
    if ty_1 ~= "table" then
        if ty_1 == "string" and string.len(ty_1) > 100 then
            return false
        end
        local v99 = true
        local v100
        if ty_1 == "table" then
            v100 = v99
        else
            v100 = true
            if ty_1 ~= "string" then
                v100 = true
                if ty_1 ~= "boolean" then
                    v100 = true
                    if ty_1 ~= "number" then
                        v100 = ty_1 == "nil"
                    end
                end
            end
        end
        return v100
    else
        for key_4, value_13 in a1 do
            if tbl_upv_1.is_utf8_compatible(key_4) and not tbl_upv_1.is_utf8_compatible(value_13) or not tbl_upv_1.is_utf8_compatible(key_4) then
                return false
            end
        end
        if ty_1 == "string" and string.len(ty_1) > 100 then
            return false
        end
        local v99 = true
        local v100
        if ty_1 == "table" then
            v100 = v99
        else
            v100 = true
            if ty_1 ~= "string" then
                v100 = true
                if ty_1 ~= "boolean" then
                    v100 = true
                    if ty_1 ~= "number" then
                        v100 = ty_1 == "nil"
                    end
                end
            end
        end
        return v100
    end
end
function tbl_upv_1.deep_copy(a1)
    --[[
      name: deep_copy
      line: 1105
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    if typeof(a1) ~= "table" then
        return a1
    end
    local tbl_8 = {}
    for key_5, value_14 in a1 do
        tbl_8[key_5] = tbl_upv_1.deep_copy(value_14)
    end
    return tbl_8
end
function tbl_upv_1.cubic_tween(a1, a2, a3, a4, a5)
    --[[
      name: cubic_tween
      line: 1116
      upvalues:
        tbl_upv_3 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        TweenService_upv_1 (copy, index: 3)
    ]]
    if tbl_upv_3[a1] then
        tbl_upv_3[a1]:Cancel()
        tbl_upv_3[a1] = nil
    end
    local tbl_upv_9 = {}
    for key_6, _ in a3 do
        tbl_upv_9[key_6] = a1[key_6]
    end
    local u5 = Instance.new("NumberValue")
    u5.Changed:Connect(
        function(a6)
            --[[
              line: 1123
              upvalues:
                a3 (copy, index: 1)
                a1 (copy, index: 2)
                tbl_upv_1 (copy, index: 3)
                tbl_upv_9 (copy, index: 4)
                a4 (copy, index: 5)
                a5 (copy, index: 6)
                u5 (copy, index: 7)
            ]]
            for key_7, _ in a3 do
                a1[key_7] = tbl_upv_1.cubic_blerp(tbl_upv_9[key_7], a3[key_7], a4[key_7], a5[key_7], a6)
            end
            if not (a6 >= 1) then
                return
            end
            u5:Destroy()
        end
    )
    local v101 = TweenService_upv_1:Create(u5, a2, {Value = 1})
    v101:Play()
    tbl_upv_3[a1] = v101
    return v101
end
function tbl_upv_1.absolute_size(a1, a2)
    --[[
      name: absolute_size
      line: 1137
    ]]
    local abs_1 = math.abs
    local v102 = a2 or (a1:GetPivot())
    local v103 = a1:GetExtentsSize()
    local X_2 = v103.X
    local Y_2 = v103.Y
    local Z_2 = v103.Z
    local _, v113, v114, v104, v105, v106, v107, v108, v109, v110, v111, v112 = v102:components()
    return (Vector3.new(((abs_1(v104) * X_2) + (abs_1(v105) * Y_2)) + (abs_1(v106) * Z_2), ((abs_1(v107) * X_2) + (abs_1(v108) * Y_2)) + (abs_1(v109) * Z_2), ((abs_1(v110) * X_2) + (abs_1(v111) * Y_2)) + (abs_1(v112) * Z_2)))
end
function tbl_upv_1.move_cframe_to_closest(a1, a2)
    --[[
      name: move_cframe_to_closest
      line: 1153
    ]]
    local Position_2 = a2.Position
    local LookVector_1 = a2.LookVector
    return CFrame.new(Position_2 + (LookVector_1 * (a1.Position - Position_2):Dot(LookVector_1))) * (a2 - Position_2)
end
function tbl_upv_1.create_cache_table(a1, a2)
    --[[
      name: create_cache_table
      line: 1212
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local tbl_10 = {}
    function tbl_10.__index(a3, a4)
        --[[
          name: __index
          line: 1216
          upvalues:
            a2 (copy, index: 1)
        ]]
        if a3.tab[a4] then
            if a2 then
                a3.tab[a4].destroy()
            end
            return a3.tab[a4].value
        end
        return nil
    end
    function tbl_10.__newindex(a5, a6, a7)
        --[[
          name: __newindex
          line: 1226
          upvalues:
            tbl_upv_1 (copy, index: 1)
            a1 (copy, index: 2)
        ]]
        local v113 = nil
        if a7 ~= nil then
            local tab_1 = a5.tab
            v113 = a5.tab[a6]
            if not (v113) then
                v113 = {}
                v113.destroy = tbl_upv_1.ov(
                    function()
                        --[[
                          line: 1234
                          upvalues:
                            a1 (copy, index: 1)
                            a5 (copy, index: 2)
                            a6 (copy, index: 3)
                        ]]
                        task.wait(a1)
                        a5.tab[a6] = nil
                    end
                )
            end
            tab_1[a6] = v113
            a5.tab[a6].value = a7
            a5.tab[a6].destroy()
        else
            if a5.tab[a6] then
                a5.tab[a6].destroy:cancel()
            end
            a5.tab[a6] = nil
        end
    end
    return (setmetatable({tab = {}}, tbl_10))
end
function tbl_upv_1.create_reinforce(a1)
    --[[
      name: create_reinforce
      line: 1247
    ]]
    local X_3 = a1.Size.X
    local v114 = math.min(8, a1.Size.Y)
    local Size_1 = script.Plate.Size
    local Y_3 = Size_1.Y
    local v115 = math.floor(v114 / Y_3)
    local v116 = Y_3 + (v114 % Y_3) / v115
    local X_4 = Size_1.X
    local v117 = math.floor(X_3 / X_4)
    local v118 = X_4 + (X_3 % X_4) / v117
    local v119 = Vector3.new(v118, v116, 0.3)
    local v120 = a1.CFrame - (a1.CFrame.RightVector * (a1.Size.X * 0.5)) - a1.CFrame.UpVector * (a1.Size.Y * 0.5)
    local v121 = Instance.new("Model")
    v121.Name = "Reinforcement"
    local v122, v123 = nil, nil
    v121 = v121
    for n_1 = 0, v115 - 1 do
        local v124 = n_1 % 2 == 1
        if v124 then
            v122 = v117
        else
            v122 = v117 - 1
        end
        local v125 = 0
        local v126 = 0
        for n_2 = 0, v122 do
            if v124 then
                if n_2 == 0 or n_2 == v122 then
                    v123 = v120 + (v120.RightVector * (v125 + (v118 * 0.25))) + v120.UpVector * ((v116 * n_1) + (v116 * 0.5))
                    v125 = v125 + v118 * 0.5
                    local v127 = script.Plate:Clone()
                    v127.Parent = v121
                    v127.CFrame = v123
                    if v124 and (n_2 == 0 or n_2 == v122) then
                        v127.Size = Vector3.new(v118 * 0.5, v116, v119.Z)
                        v126 = v126 + 1
                        if v126 % 2 == 0 then
                            local v128 = script.PlatePole:Clone()
                            v128.Parent = v121
                            v128.CFrame = v123 * CFrame.new(0, 0, (a1.Size.Z * 0.5) + (v119.Z * 0.5))
                            v128.Size = Vector3.new(0.4, 0.4, a1.Size.Z + 0.2)
                        end
                    end
                    v127.Size = Vector3.new(v118, v116, v119.Z)
                    v126 = v126 + 1
                    if v126 % 2 == 0 then
                        local v128 = script.PlatePole:Clone()
                        v128.Parent = v121
                        v128.CFrame = v123 * CFrame.new(0, 0, (a1.Size.Z * 0.5) + (v119.Z * 0.5))
                        v128.Size = Vector3.new(0.4, 0.4, a1.Size.Z + 0.2)
                    end
                end
                v123 = v120 + (v120.RightVector * (v125 + (v118 * 0.5))) + v120.UpVector * ((v116 * n_1) + (v116 * 0.5))
            else
                v123 = v120 + v120.RightVector * (v125 + v118 * 0.5) + v120.UpVector * (v116 * n_1 + v116 * 0.5)
            end
            v125 = v125 + v118
            local v127 = script.Plate:Clone()
            v127.Parent = v121
            v127.CFrame = v123
            if v124 and (n_2 == 0 or n_2 == v122) then
                v127.Size = Vector3.new(v118 * 0.5, v116, v119.Z)
                v126 = v126 + 1
                if v126 % 2 == 0 then
                    local v128 = script.PlatePole:Clone()
                    v128.Parent = v121
                    v128.CFrame = v123 * CFrame.new(0, 0, (a1.Size.Z * 0.5) + (v119.Z * 0.5))
                    v128.Size = Vector3.new(0.4, 0.4, a1.Size.Z + 0.2)
                end
            end
            v127.Size = Vector3.new(v118, v116, v119.Z)
            v126 = v126 + 1
            if v126 % 2 == 0 then
                local v128 = script.PlatePole:Clone()
                v128.Parent = v121
                v128.CFrame = v123 * CFrame.new(0, 0, (a1.Size.Z * 0.5) + (v119.Z * 0.5))
                v128.Size = Vector3.new(0.4, 0.4, a1.Size.Z + 0.2)
            end
        end
    end
    return v121
end
function tbl_upv_1.create_barricade(a1)
    --[[
      name: create_barricade
      line: 1315
    ]]
    local v129 = a1.Size.Y
    if a1:GetAttribute("Type") == "Door" then
        v129 = math.floor(a1.Size.Y)
    end
    local Size_2 = script.DoorPlank.Size
    local v130 = Vector3.new(a1.Size.X * 0.5, Size_2.Y, Size_2.Z)
    local v131 = math.round(v129 / v130.Y)
    local v132 = a1.CFrame - (a1.CFrame.RightVector * (a1.Size.X * 0.5)) - a1.CFrame.UpVector * (a1.Size.Y * 0.5)
    local v133 = Instance.new("Model")
    local v134 = Color3.fromRGB(245, 205, 48)
    local v135 = Color3.fromRGB(27, 42, 53)
    local v136 = 0
    v133.Name = "DoorBarricade"
    v136 = v136
    for n_3 = 0, v131 - 1 do
        v136 = v136
        for n_4 = 0, 1 do
            local v137 = script.DoorPlank:Clone()
            if n_3 % 2 ~= 0 then
                v137.Color = v135
            else
                v137.Color = v134
            end
            local v138 = v136 + 1
            v137.Parent = v133
            v137.CFrame = ((v132 + (v132.RightVector * (v130.X * 0.5))) + (v132.UpVector * ((v130.Y * n_3) + (v130.Y * 0.5)))) * CFrame.Angles(0, 0, 0) * CFrame.new(v130.X * n_4, 0, 0)
            v137.Size = Vector3.new(v130.X, v130.Y * 1, v130.Z * 1)
            v136 = v138
        end
    end
    return v133
end
function tbl_upv_1.create_planks_barricade(a1)
    --[[
      name: create_planks_barricade
      line: 1366
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v139 = a1.Size.Y
    if a1:GetAttribute("Type") == "Door" then
        v139 = math.floor(a1.Size.Y)
    end
    local Size_3 = script.SolidDoorPlank.Size
    local v140 = Vector3.new(a1.Size.X, Size_3.Y, Size_3.Z)
    local v141 = math.round(v139 / v140.Y)
    local v142 = a1.CFrame - (a1.CFrame.RightVector * (a1.Size.X * 0.5)) - a1.CFrame.UpVector * (a1.Size.Y * 0.5)
    local v143 = Instance.new("Model")
    v143.Name = "DoorBarricade"
    for n_5 = 0, v141 - 1 do
        local v144 = tbl_upv_1.rand(-3, 3)
        local v145 = tbl_upv_1.rand(0.85, 0.9)
        local v146 = tbl_upv_1.rand(0.95, 1.05)
        local v147 = script.SolidDoorPlank:Clone()
        v147.Parent = v143
        v147.CFrame = ((v142 + (v142.RightVector * (v140.X * 1))) + (v142.UpVector * ((v140.Y * n_5) + (v140.Y * 0.5)))) * CFrame.Angles(0, 0, math.rad(v144))
        v147.Size = Vector3.new(v140.X, v140.Y * v145, v140.Z * v146)
    end
    return v143
end
function tbl_upv_1.create_motor(a1, a2)
    --[[
      name: create_motor
      line: 1401
    ]]
    local v148 = Instance.new("Motor6D")
    v148.Part0 = a1
    v148.Part1 = a2
    v148.C1 = a2.PivotOffset
    v148.C0 = a1.CFrame:ToObjectSpace(a2:GetPivot())
    a2.Anchored = false
    return v148
end
function tbl_upv_1.create_metal_barricade(a1)
    --[[
      name: create_metal_barricade
      line: 1418
    ]]
    local X_5 = a1.Size.X
    local v149 = a1.Size.Y
    if a1:GetAttribute("Type") == "Door" then
        v149 = math.floor(a1.Size.Y)
    end
    local Size_4 = script.MetalRoll.Size
    local v150 = Vector3.new(a1.Size.X, Size_4.Y, Size_4.Z)
    local v151 = math.round(v149 / v150.Y)
    local v152 = a1.CFrame - (a1.CFrame.RightVector * (a1.Size.X * 0.5)) - a1.CFrame.UpVector * (a1.Size.Y * 0.5)
    local v153 = Instance.new("Model")
    v153.Name = "DoorBarricade"
    for n_6 = 0, v151 - 1 do
        local v154 = script.MetalRoll:Clone()
        v154.Parent = v153
        v154.CFrame = (v152 + (v152.RightVector * (v150.X * 1))) + (v152.UpVector * ((v150.Y * n_6) + (v150.Y * 0.5)))
        v154.Size = Vector3.new(X_5, v149, v150.Z)
    end
    return v153
end
local tbl_upv_11 = {}
function tbl_upv_1.tween_slow(a1, a2, a3, a4)
    --[[
      name: tween_slow
      line: 1451
      upvalues:
        tbl_upv_11 (copy, index: 1)
    ]]
    local Time_1 = a2.Time
    local tbl_12 = {}
    for key_8, _ in a3 do
        tbl_12[key_8] = a1[key_8]
    end
    local tbl_13 = {elapsed_time = 0, accumulator = 0}
    tbl_13.instance = a1
    tbl_13.start_values = tbl_12
    tbl_13.goal = a3
    tbl_13.total_time = Time_1
    tbl_13.step_interval = a4 or 0.1
    tbl_upv_11[a1] = tbl_13
    return tbl_13
end
if RunService_upv_1:IsServer() then
    tbl_upv_1.tween = tbl_upv_1.tween_slow
    RunService_upv_1.Heartbeat:Connect(
        function(a1)
            --[[
              line: 1480
              upvalues:
                tbl_upv_11 (copy, index: 1)
                tbl_upv_1 (copy, index: 2)
            ]]
            for key_9, value_15 in tbl_upv_11 do
                value_15.elapsed_time = value_15.elapsed_time + a1
                value_15.accumulator = value_15.accumulator + a1
                if not (value_15.step_interval <= value_15.accumulator) then
                    continue
                end
                value_15.accumulator = 0
                local v155 = math.min(value_15.elapsed_time / value_15.total_time, 1)
                for key_10, value_16 in pairs(value_15.goal) do
                    value_15.instance[key_10] = tbl_upv_1.lerp(value_15.start_values[key_10], value_16, v155)
                end
                if not (v155 >= 1) then
                    continue
                end
                tbl_upv_11[key_9] = nil
                if value_15.on_complete then
                    value_15.on_complete()
                end
            end
        end
    )
end
function tbl_upv_1.are_points_collinear(a1, a2)
    --[[
      name: are_points_collinear
      line: 1505
    ]]
    if not (#a1 < 3) then
        for n_7 = 3, #a1 do
            if not (a2 < math.abs(1 - (a1[2] - a1[1]).unit:Dot((a1[n_7] - a1[1]).unit))) then
                continue
            end
            return false
        end
    end
    return true
end
function tbl_upv_1.is_close(a1, a2, a3)
    --[[
      name: is_close
      line: 1522
    ]]
    a3 = a3 or 0.001
    if typeof(a1) == typeof(a2) then
        if typeof(a1) ~= "number" then
            if typeof(a1) ~= "Vector3" and typeof(a1) ~= "Vector2" then
                if typeof(a1) ~= "CFrame" then
                    error("Unsupported types: values must be numbers, vectors, or CFrames.")
                    return
                else
                    local v156, v157, v158 = a1:ToOrientation()
                    local v159, v160, v161 = a2:ToOrientation()
                    local v162 = ((a1.Position - a2.Position).Magnitude <= a3) and ((math.abs(v156 - v159) <= a3) and ((math.abs(v157 - v160) <= a3) and (math.abs(v158 - v161) <= a3)))
                    return v162
                end
            end
            return (a1 - a2).Magnitude <= a3
        else
            local v163 = math.abs(a1 - a2) <= a3
            return v163
        end
    else
        return false
    end
end
function tbl_upv_1.frame_dt(a1, a2)
    --[[
      name: frame_dt
      line: 1542
    ]]
    return 1 - ((1 - a1) ^ (a2 * 60))
end
function tbl_upv_1.frame_lerp(a1, a2, a3, a4)
    --[[
      name: frame_lerp
      line: 1546
    ]]
    local v164 = 1 - (1 - a3) ^ (a4 * 60)
    if typeof(a1) ~= "number" then
        return a1:Lerp(a2, v164)
    end
    return a1 + (v164 * (a2 - a1))
end
function tbl_upv_1.hook_first_child(a1, a2, a3)
    --[[
      name: hook_first_child
      line: 1555
    ]]
    local v165 = a1:FindFirstChild(a2)
    if v165 then
        task.spawn(a3, v165)
    else
        local u6 = nil
        local v166 = a1.ChildAdded:Connect(
            function(a4)
                --[[
                  line: 1562
                  upvalues:
                    a2 (copy, index: 1)
                    u6 (ref,  index: 2)
                    a3 (copy, index: 3)
                ]]
                if a4.Name ~= a2 then
                    return
                end
                u6:Disconnect()
                task.spawn(a3, a4)
            end
        )
        u6 = v166
    end
end
function tbl_upv_1.hook_children(a1, a2, a3)
    --[[
      name: hook_children
      line: 1570
    ]]
    if typeof(a1) ~= "table" then
        local tbl_14 = {a1}
        a1 = tbl_14
    end
    for _, value_17 in a1 do
        for v1, value_18 in pairs(value_17:GetChildren()) do
            task.spawn(a2, value_18, true)
        end
        value_17.ChildAdded:Connect(
            function(a4)
                --[[
                  line: 1579
                  upvalues:
                    a2 (copy, index: 1)
                ]]
                a2(a4, true)
            end
        )
        if a3 then
            value_17.ChildRemoved:Connect(
                function(a5)
                    --[[
                      line: 1583
                      upvalues:
                        a2 (copy, index: 1)
                    ]]
                    a2(a5, false)
                end
            )
        end
    end
end
function tbl_upv_1.hook_child_added(a1, a2)
    --[[
      name: hook_child_added
      line: 1598
    ]]
    for _, value_19 in a1:GetChildren() do
        task.spawn(a2, value_19)
    end
    return a1.ChildAdded:Connect(a2)
end
function tbl_upv_1.hook_descendant_added(a1, a2)
    --[[
      name: hook_descendant_added
      line: 1605
    ]]
    for _, value_20 in a1:GetDescendants() do
        task.spawn(a2, value_20)
    end
    return a1.DescendantAdded:Connect(a2)
end
function tbl_upv_1.capitalize_first(a1)
    --[[
      name: capitalize_first
      line: 1612
    ]]
    return a1:sub(1, 1):upper() .. a1:sub(2)
end
function tbl_upv_1.hook_descendants(a1, a2, a3)
    --[[
      name: hook_descendants
      line: 1616
    ]]
    for _, value_21 in a1:GetDescendants() do
        task.spawn(a2, value_21, true)
    end
    local v167 = nil
    local v168 = a1.DescendantAdded:Connect(
        function(a4)
            --[[
              line: 1621
              upvalues:
                a2 (copy, index: 1)
            ]]
            a2(a4, true)
        end
    )
    if a3 then
        local v169 = a1.DescendantRemoving:Connect(
            function(a5)
                --[[
                  line: 1625
                  upvalues:
                    a2 (copy, index: 1)
                ]]
                a2(a5, false)
            end
        )
        v167 = v169
    end
    return v168, v167
end
function tbl_upv_1.hook_ancestor(a1, a2)
    --[[
      name: hook_ancestor
      line: 1632
    ]]
    task.spawn(a2, a1.Parent)
    return a1.AncestryChanged:Connect(
        function(a3, a4)
            --[[
              line: 1634
              upvalues:
                a2 (copy, index: 1)
            ]]
            a2(a4)
        end
    )
end
function tbl_upv_1.raycast(a1, a2, a3, a4)
    --[[
      name: raycast
      line: 1639
    ]]
    local v170 = game.Workspace:Raycast(a1, a2, a3)
    if not v170 then
        return
    end
    if a4 then
        a4(v170)
    else
        return v170
    end
end
function tbl_upv_1.reverse_angle(a1)
    --[[
      name: reverse_angle
      line: 1650
    ]]
    local v171 = a1 + math.pi
    return ((v171 >= math.tau) and (v171 - math.tau)) or v171
end
function tbl_upv_1.inverse_inner(a1)
    --[[
      name: inverse_inner
      line: 1660
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v172, v173, v174 = a1:ToOrientation()
    return CFrame.new(-a1.X, a1.Y, a1.Z) * CFrame.Angles(v172, tbl_upv_1.reverse_angle(v173), tbl_upv_1.reverse_angle(v174))
end
function tbl_upv_1.parts_on_ray(a1, a2, a3, a4, a5)
    --[[
      name: parts_on_ray
      line: 1665
    ]]
    local v177
    local v175 = a3 or {}
    local v176 = RaycastParams.new()
    v176.FilterType = Enum.RaycastFilterType.Exclude
    v176.FilterDescendantsInstances = v175
    repeat
        if a5 then
            if typeof(a5) ~= "number" then
                v177 = game.Workspace:Blockcast(a1, a5, a2, v176)
            else
                v177 = game.Workspace:Spherecast(a1, a5, a2, v176)
            end
        else
            v177 = game.Workspace:Raycast(a1, a2, v176)
        end
        if v177 then
            v176:AddToFilter(v177.Instance)
            if (not (a4) or a4(v177) ~= false) and not (v177) then
                break
            end
            return
        end
    until not (v177)
    return v175
end
function tbl_upv_1.does_sphere_intersect_part(a1, a2, a3, a4)
    --[[
      name: does_sphere_intersect_part
      line: 1694
    ]]
    local v178 = a3:pointToObjectSpace(a1)
    local v179 = a4 * 0.5
    local v180 = (a1 - a3:pointToWorldSpace(Vector3.new(math.clamp(v178.X, -v179.X, v179.X), math.clamp(v178.Y, -v179.Y, v179.Y), math.clamp(v178.Z, -v179.Z, v179.Z)))).Magnitude ^ 2 <= a2 ^ 2
    return v180
end
function tbl_upv_1.are_spheres_intersecting(a1, a2, a3, a4)
    --[[
      name: are_spheres_intersecting
      line: 1711
    ]]
    return (a1 - a3).Magnitude <= (a2 + a4)
end
function tbl_upv_1.cut_part_in_half(a1, a2)
    --[[
      name: cut_part_in_half
      line: 1716
    ]]
    local tbl_15 = {a2.X, a2.Y, a2.Z}
    table.sort(tbl_15)
    if not (tbl_15[3] >= 1) then
        return
    end
    local v181 = nil
    local v182 = nil
    local v183 = nil
    if tbl_15[3] == a2.Z then
        v181 = Vector3.new(a2.X, a2.Y, a2.Z * 0.5)
        v182, v183 = a1 * CFrame.new(0, 0, a2.Z * 0.25), a1 * CFrame.new(0, 0, -a2.Z * 0.25)
    elseif tbl_15[3] == a2.Y then
        v181 = Vector3.new(a2.X, a2.Y * 0.5, a2.Z)
        v182, v183 = a1 * CFrame.new(0, a2.Y * 0.25, 0), a1 * CFrame.new(0, -a2.Y * 0.25, 0)
    elseif tbl_15[3] == a2.X then
        v181 = Vector3.new(a2.X * 0.5, a2.Y, a2.Z)
        v182, v183 = a1 * CFrame.new(a2.X * 0.25, 0, 0), a1 * CFrame.new(-a2.X * 0.25, 0, 0)
    end
    return v182, v183, v181
end
local function base_penetrate(a1)
    --[[
      name: base_penetrate
      line: 1743
    ]]
    local Instance_1 = a1.Instance
    local Parent_1 = Instance_1.Parent
    local v184 = Instance_1:GetAttribute("Hard") or (Parent_1:GetAttribute("Hard"))
    local v185 = not Instance_1:GetAttribute("Soft") and (not Parent_1:GetAttribute("Soft") and ((Instance_1.CanCollide == true) and (Instance_1.Transparency < 1)))
    if v184 or v185 then
        local tbl_16 = {Instance_1.Size.X, Instance_1.Size.Y, Instance_1.Size.Z}
        table.sort(tbl_16)
        if not (tbl_16[2] >= 1.45) and (not (Instance_1:HasTag("WallPart")) and not (v184) or not (tbl_16[2] > 0.5)) then
            return true
        end
        return false, 0
    end
    return true
end
function tbl_upv_1.can_ray_penetrate(a1, a2, a3, a4)
    --[[
      name: can_ray_penetrate
      line: 1759
      upvalues:
        base_penetrate (copy, index: 1)
    ]]
    local v186 = a3 or {}
    local v187 = a4 or base_penetrate
    v187 = RaycastParams.new()
    v187.FilterType = Enum.RaycastFilterType.Exclude
    v187.FilterDescendantsInstances = v186
    local v188
    repeat
        v188 = game.Workspace:Raycast(a1, a2 - a1, v187)
        if v188 then
            v187:AddToFilter(v188.Instance)
            local v189, v190 = v187(v188)
            if not (v189) then
                return v190
            end
        end
    until not (v188)
    return 1
end
function tbl_upv_1.validate_position(origin, target, raycastparams)
    --[[
      name: validate_position
      line: 1785
    ]]
    if not target then
        return origin
    end
    local v191 = ((origin.Y - target.Y > 3) and (origin.Y - 3)) or (((target.Y - origin.Y > 3) and (origin.Y + 3)) or target.Y)
    local v192 = Vector3.new(origin.X, v191, origin.Z)
    local v193 = Vector3.new(target.X, v191, target.Z)
    local LookVector_2 = CFrame.lookAt(v192, v193).LookVector
    local Magnitude_3 = (v192 - v193).Magnitude
    local v194 = workspace:Raycast(v192, LookVector_2 * math.min(3, Magnitude_3), raycastparams)
    if v194 then
        return v194.Position - (LookVector_2 * 0.1)
    elseif Magnitude_3 > 3 then
        return target - (LookVector_2 * (Magnitude_3 - 3))
    else
        return target
    end
end
function tbl_upv_1.no_collide(a1, a2)
    --[[
      name: no_collide
      line: 1811
    ]]
    local Humanoid_1 = a1:FindFirstChild("Humanoid")
    for _, value_22 in a1:GetDescendants() do
        if not (value_22:IsA("BasePart")) then
            continue
        end
        if value_22.CanCollide or Humanoid_1 and a1.PrimaryPart == value_22 then
            local v195 = Instance.new("NoCollisionConstraint")
            v195.Part0 = value_22
            v195.Part1 = a2
            v195.Parent = a2
        end
    end
end
function tbl_upv_1.within_view(a1, a2)
    --[[
      name: within_view
      line: 1824
    ]]
    local CurrentCamera_1 = workspace.CurrentCamera
    local v196 = a1 - CurrentCamera_1.CFrame.Position
    local Magnitude_4 = v196.Magnitude
    if Magnitude_4 < 0.01 then
        return true
    end
    local v197 = CurrentCamera_1.CFrame.LookVector:Dot(v196.Unit)
    if math.cos(a2 / Magnitude_4) < v197 then
        return true
    end
    return false
end
function tbl_upv_1.task_buffer(a1, ...)
    --[[
      name: task_buffer
      line: 1849
      upvalues:
        BufferingFunction_upv_1 (copy, index: 1)
    ]]
    BufferingFunction_upv_1.bf(
        function(a2, ...)
            --[[
              line: 1850
            ]]
            local success_1, v198 = pcall(a2, ...)
            if (success_1) then
                return
            end
            warn("[Client]", v198)
        end,
        "task_buffer"
    )(a1, ...)
end
function tbl_upv_1.rotate_movement_to_cframe(a1, a2)
    --[[
      name: rotate_movement_to_cframe
      line: 1860
    ]]
    if a1.Magnitude == 0 then
        return Vector3.new(0, 0, 0)
    end
    local RightVector_1 = a2.RightVector
    local v199 = Vector3.new(RightVector_1.X, 0, RightVector_1.Z) * a1.X + a2.LookVector * a1.Z
    if v199.Magnitude ~= 0 and v199.Magnitude == v199.Magnitude then
        return v199
    end
    return Vector3.new(0, 0, 0)
end
function tbl_upv_1.rotate_humanoid_movement_to_cframe(a1, a2)
    --[[
      name: rotate_humanoid_movement_to_cframe
      line: 1879
    ]]
    if a1.Magnitude == 0 then
        return Vector3.new(0, 0, 0)
    end
    local LookVector_3 = a2.LookVector
    local RightVector_2 = a2.RightVector
    local Unit_8 = Vector3.new(LookVector_3.X, 0, LookVector_3.Z).Unit
    local v200 = Vector3.new(RightVector_2.X, 0, RightVector_2.Z).Unit * a1.X + Unit_8 * a1.Z
    if v200.Magnitude ~= 0 and v200.Magnitude == v200.Magnitude then
        return (Vector3.new(v200.X, 0, v200.Z))
    end
    return Vector3.new(0, 0, 0)
end
function tbl_upv_1.filter_text(a1, a2)
    --[[
      name: filter_text
      line: 1898
      upvalues:
        TextService_upv_1 (copy, index: 1)
    ]]
    local u7 = nil
    if not pcall(
        function()
            --[[
              line: 1900
              upvalues:
                u7 (ref,  index: 1)
                TextService_upv_1 (copy, index: 2)
                a1 (copy, index: 3)
                a2 (copy, index: 4)
            ]]
            u7 = TextService_upv_1:FilterStringAsync(a1, a2)
        end
    ) then
        return false, "Could not filter text"
    end
    local success_2, v201 = pcall(
        function()
            --[[
              line: 1905
              upvalues:
                u7 (ref, index: 1)
            ]]
            return u7:GetNonChatStringForBroadcastAsync()
        end
    )
    if success_2 then
        return v201
    end
    return false, "Error filtering text"
end
function tbl_upv_1.sanitize_text(a1)
    --[[
      name: sanitize_text
      line: 1919
    ]]
    return (a1:gsub("[^a-zA-Z\195\129\195\132\195\137\195\150\195\156\195\161\195\164\195\169\195\182\195\188 ]", ""):sub(1, 12))
end
function tbl_upv_1.can_interact(a1, a2)
    --[[
      name: can_interact
      line: 1927
      upvalues:
        RunService_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
    ]]
    if a1.Character == nil then
        return
    end
    if a1.Character:FindFirstChild("collision") then
        local v202
        if a2:IsA("Model") then
            v202 = a2:GetExtentsSize()
        else
            v202 = (not a2:IsA("BasePart")) or (a2.Size)
        end
        local v203 = math.max(1.5, v202.Magnitude * 0.333)
        if RunService_upv_1:IsClient() then
            local _ = tbl_upv_1.within_view(a2:GetPivot().Position, v203)
        end
        local v204 = ((RunService_upv_1:IsServer()) and 2) or 1
        if (a1.Character.collision.Position - a2:GetPivot().Position).Magnitude < (v203 + 3) * v204 then
            v204 = true
        else
            v204 = false
        end
        return true and v204
    end
end
function tbl_upv_1.is_behind(a1, a2)
    --[[
      name: is_behind
      line: 1949
    ]]
    local v205 = a1.LookVector:Dot((a2.Position - a1.Position).Unit) > 0
    return v205
end
function tbl_upv_1.can_ray_reach(a1, a2, a3, a4)
    --[[
      name: can_ray_reach
      line: 1955
    ]]
    local v206 = a3 or {}
    local v207 = RaycastParams.new()
    v207.FilterType = Enum.RaycastFilterType.Exclude
    v207.FilterDescendantsInstances = v206
    v207.CollisionGroup = a4 or "Default"
    local v208
    repeat
        v208 = game.Workspace:Raycast(a1, a2 - a1, v207)
        if v208 then
            local Instance_2 = v208.Instance
            v207:AddToFilter(Instance_2)
            if Instance_2:GetAttribute("Hard") or Instance_2.Parent:GetAttribute("Hard") then
                return false
            end
            if Instance_2.CanCollide == true and Instance_2.Transparency < 1 and (v208.Position - a2).Magnitude > 0.3 then
                local tbl_17 = {Instance_2.Size.X, Instance_2.Size.Y, Instance_2.Size.Z}
                table.sort(tbl_17)
                if not (tbl_17[2] > 1) and (not (Instance_2:HasTag("WallPart")) or not (tbl_17[2] > 0.5)) and not (v208) then
                    break
                end
            elseif not (v208) then
                break
            end
            return false
        end
    until not (v208)
    return true
end
function tbl_upv_1.is_looking_towards(a1, a2, a3)
    --[[
      name: is_looking_towards
      line: 1988
    ]]
    local v209 = math.acos(a1.LookVector:Dot((a2 - a1.Position).Unit)) <= math.rad(a3 or 90)
    return v209
end
function tbl_upv_1.watch_parent(a1, a2)
    --[[
      name: watch_parent
      line: 2002
    ]]
    a2(a1.Parent)
    return a1.AncestryChanged:Connect(
        function()
            --[[
              line: 2004
              upvalues:
                a2 (copy, index: 1)
                a1 (copy, index: 2)
            ]]
            a2(a1.Parent)
        end
    )
end
function tbl_upv_1.wait_for_parent(a1, a2, a3)
    --[[
      name: wait_for_parent
      line: 2009
    ]]
    if a1.Parent ~= a2 then
        local u8 = nil
        local v210 = a1.AncestryChanged:Connect(
            function()
                --[[
                  line: 2013
                  upvalues:
                    a1 (copy, index: 1)
                    a2 (copy, index: 2)
                    a3 (copy, index: 3)
                    u8 (ref,  index: 4)
                ]]
                if a1.Parent ~= a2 then
                    return
                end
                a3()
                u8:Disconnect()
            end
        )
        u8 = v210
    else
        a3()
    end
end
function tbl_upv_1.watch_property(a1, a2, a3)
    --[[
      name: watch_property
      line: 2022
    ]]
    a3(a1[a2], a1[a2])
    local u9 = a1[a2]
    local v211 = a1:GetPropertyChangedSignal(a2)
    local v212 = function()
        --[[
          line: 2025
          upvalues:
            a3 (copy, index: 1)
            a1 (copy, index: 2)
            a2 (copy, index: 3)
            u9 (ref,  index: 4)
        ]]
        a3(a1[a2], u9)
        u9 = a1[a2]
    end
    return v211:Connect(v212)
end
function tbl_upv_1.watch_attribute(a1, a2, a3)
    --[[
      name: watch_attribute
      line: 2031
    ]]
    a3(a1:GetAttribute(a2), a1:GetAttribute(a2))
    local u10 = a1:GetAttribute(a2)
    local v213 = a1:GetAttributeChangedSignal(a2)
    local v214 = function()
        --[[
          line: 2034
          upvalues:
            a3 (copy, index: 1)
            a1 (copy, index: 2)
            a2 (copy, index: 3)
            u10 (ref,  index: 4)
        ]]
        a3(a1:GetAttribute(a2), u10)
        u10 = a1:GetAttribute(a2)
    end
    return v213:Connect(v214)
end
function tbl_upv_1.wait_for_property(a1, a2)
    --[[
      name: wait_for_property
      line: 2040
    ]]
    while a1[a2] == nil do
        a1:GetPropertyChangedSignal(a2):Wait()
    end
    return a1[a2]
end
function tbl_upv_1.wait_for_attribute(a1, a2)
    --[[
      name: wait_for_attribute
      line: 2047
    ]]
    while a1:GetAttribute(a2) == nil do
        a1:GetAttributeChangedSignal(a2):Wait()
    end
    return a1:GetAttribute(a2)
end
function tbl_upv_1.create_sphere_attachment(a1, a2)
    --[[
      name: create_sphere_attachment
      line: 2054
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v215 = script.SphereAttachment:Clone()
    v215.Parent = game.Workspace
    v215.CFrame = CFrame.new(a1)
    if a2 then
        tbl_upv_1.debris(v215, a2)
    end
    return v215
end
function tbl_upv_1.average(...)
    --[[
      name: average
      line: 2064
    ]]
    local v216 = table.pack(...)
    local n_8 = v216.n
    if n_8 == 0 then
        return 0
    end
    local v217 = 0
    for _, value_23 in ipairs(v216) do
        v217 = v217 + value_23
    end
    return v217 / n_8
end
function tbl_upv_1.calculate_rating_change(a1, a2, a3, a4, a5)
    --[[
      name: calculate_rating_change
      line: 2075
    ]]
    local v218 = math.min(2500, a1) - math.min(2500, a2)
    local v219 = math.max(0, a5 or 25)
    local v220 = math.clamp(-v218 / 50, -v219, v219)
    local v221
    if a3 then
        v221 = math.max(0, (v219 + v220) + a4)
    else
        v221 = math.min(0, (-v219 + v220) + a4)
    end
    return (math.round(v221))
end
function tbl_upv_1.fit_part_in_space(a1, a2, a3)
    --[[
      name: fit_part_in_space
      line: 2095
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v222 = a1:GetPivot()
    local Position_upv_3 = v222.Position
    local v223 = a3 * 0.5
    local function get_dist(a4, a5)
        --[[
          name: get_dist
          line: 2100
          upvalues:
            tbl_upv_1 (copy, index: 1)
            Position_upv_3 (copy, index: 2)
        ]]
        local v224 = nil
        tbl_upv_1.parts_on_ray(Position_upv_3, a4 * a5, nil, function() end)
        local v225 = (v224 and (v224.Distance)) or a5
        return v225
    end
    local X_6 = v223.X
    local v226 = nil
    tbl_upv_1.parts_on_ray(Position_upv_3, v222.RightVector * X_6, nil, function() end)
    local v227 = (v226 and (v226.Distance)) or X_6
    local X_7 = v223.X
    local v228 = nil
    tbl_upv_1.parts_on_ray(Position_upv_3, -v222.RightVector * X_7, nil, function() end)
    local v229 = (v228 and (v228.Distance)) or X_7
    local Y_4 = v223.Y
    local v230 = nil
    tbl_upv_1.parts_on_ray(Position_upv_3, v222.UpVector * Y_4, nil, function() end)
    local v231 = (v230 and (v230.Distance)) or Y_4
    local v232 = v223.Y
    local v233 = nil
    tbl_upv_1.parts_on_ray(Position_upv_3, -v222.UpVector * v232, nil, function() end)
    X_6 = (v233 and (v233.Distance)) or v232
    local Z_3 = v223.Z
    local v234 = nil
    tbl_upv_1.parts_on_ray(Position_upv_3, -v222.LookVector * Z_3, nil, function() end)
    local v235 = (v234 and (v234.Distance)) or Z_3
    local Z_4 = v223.Z
    local u11 = nil
    tbl_upv_1.parts_on_ray(
        Position_upv_3,
        v222.LookVector * Z_4,
        nil,
        function(a6)
            --[[
              line: 2103
              upvalues:
                a3 (copy, index: 1)
                u11 (ref,  index: 2)
            ]]
            if not a6 or not a6.Instance then
                return
            end
            if (a6.Instance.CollisionGroup ~= "Default" or (a3.Magnitude * 0.5 < a6.Instance.Size.Magnitude)) and (a6.Instance.CanCollide) and (a6.Instance.Transparency < 1) then
                u11 = a6
                return false
            end
        end
    )
    v232 = u11 and u11.Distance or Z_4
    a1.Size = Vector3.new(v227 + v229, v231 + X_6, v235 + v232)
    a1.PivotOffset = CFrame.new((v229 - v227) * 0.5, (X_6 - v231) * 0.5, (v232 - v235) * 0.5)
    a1:PivotTo(v222)
    local tbl_18 = {}
    tbl_18.posX = v227 / v223.X
    tbl_18.negX = v229 / v223.X
    tbl_18.posY = v231 / v223.Y
    tbl_18.negY = X_6 / v223.Y
    tbl_18.posZ = v235 / v223.Z
    tbl_18.negZ = v232 / v223.Z
    return tbl_18
end
function tbl_upv_1.resize_keep_relative_pivot(a1, a2)
    --[[
      name: resize_keep_relative_pivot
      line: 2143
    ]]
    local v236 = a1:GetPivot()
    local Size_5 = a1.Size
    local PivotOffset_1 = a1.PivotOffset
    local Position_4 = PivotOffset_1.Position
    local v237 = Vector3.new(Position_4.X / Size_5.X, Position_4.Y / Size_5.Y, Position_4.Z / Size_5.Z)
    a1.Size = a2
    a1.PivotOffset = CFrame.new(Vector3.new(v237.X * a2.X, v237.Y * a2.Y, v237.Z * a2.Z)) * PivotOffset_1.Rotation
    a1:PivotTo(v236)
end
function tbl_upv_1.sum(...)
    --[[
      name: sum
      line: 2169
    ]]
    local v238 = 0
    for _, value_24 in ipairs(table.pack(...)) do
        v238 = v238 + value_24
    end
    return v238
end
function tbl_upv_1.can_damage(a1)
    --[[
      name: can_damage
      line: 2177
    ]]
    local v239
    if a1:HasTag("Breakable") then
        v239 = a1.CanCollide and (a1.CanQuery)
    else
        v239 = a1.Parent:HasTag("Breakable")
        if v239 then
            v239 = a1.CanCollide and (a1.CanQuery)
        end
    end
    return v239
end
function tbl_upv_1.get_breakable_instance(a1, a2)
    --[[
      name: get_breakable_instance
      line: 2181
    ]]
    if a2 then
        if a1.Parent:HasTag("Breakable") then
            return a1.Parent
        elseif a1:HasTag("Breakable") then
            return a1
        end
    elseif a1:HasTag("Breakable") then
        return a1
    elseif a1.Parent:HasTag("Breakable") then
        return a1.Parent
    end
end
function tbl_upv_1.is_player_alive(a1)
    --[[
      name: is_player_alive
      line: 2197
    ]]
    local Character_1 = a1.Character
    if Character_1 and Character_1:IsDescendantOf(game.Workspace) then
        local Humanoid_2 = Character_1:FindFirstChild("Humanoid")
        if Humanoid_2 and Humanoid_2.Health > 0 then
            return true
        end
    end
    return false
end
function tbl_upv_1.create_red_point(a1, a2)
    --[[
      name: create_red_point
      line: 2208
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v240 = Instance.new("Part")
    v240.Shape = Enum.PartType.Ball
    v240.Size = Vector3.new(0.15000000596046448, 0.15000000596046448, 0.15000000596046448)
    v240.Color = Color3.fromRGB(255, 0, 0)
    v240.Anchored = true
    v240.CanCollide = false
    v240.CanQuery = false
    v240.CanTouch = false
    v240.Parent = game.Workspace
    v240.CFrame = CFrame.new(a1)
    if a2 then
        tbl_upv_1.debris(v240, a2)
    end
    return v240
end
function tbl_upv_1.create_trail(a1, a2, a3)
    --[[
      name: create_trail
      line: 2226
      upvalues:
        tbl_upv_1 (copy, index: 1)
    ]]
    local v241 = Instance.new("Part")
    v241.Name = "TrailPoint"
    v241.Color = Color3.fromRGB(255, 0, 0)
    v241.Anchored = true
    v241.CanCollide = false
    v241.CanQuery = false
    v241.Transparency = 0
    v241.Size = Vector3.new(0.30000001192092896, 0.30000001192092896, 0.30000001192092896)
    v241.Shape = Enum.PartType.Ball
    v241.Parent = game.Workspace
    v241.CFrame = CFrame.new(a1)
    local v242 = Instance.new("Attachment")
    v242.Parent = v241
    local v243 = v241:Clone()
    v243.Color = Color3.fromRGB(0, 125, 255)
    v243.Parent = game.Workspace
    v243.CFrame = CFrame.new(a2)
    tbl_upv_1.debris(v241, a3 or 0.5)
    tbl_upv_1.debris(v243, a3 or 0.5)
    local v244 = Instance.new("Beam")
    v244.Parent = v241
    v244.Attachment0 = v242
    v244.Attachment1 = v243.Attachment
    v244.FaceCamera = true
    v244.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 125, 255))
    v244.Width0 = 0.2
    v244.Width1 = 0.2
end
function tbl_upv_1.load()
    --[[
      name: load
      line: 2259
    ]]
end
return tbl_upv_1
