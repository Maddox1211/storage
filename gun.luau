-- Script Path: game:GetService("ReplicatedStorage").Modules.Items.Item.Gun
-- Took 0.31s to decompile.
-- Executor: Volt (1.3.15.1)

local RunService_1 = game:GetService("RunService")
local Parent_upv_1 = require(script.Parent)
local tbl_upv_1 = {}
tbl_upv_1.__index = tbl_upv_1
setmetatable(tbl_upv_1, Parent_upv_1)
tbl_upv_1.tag = script.Name
tbl_upv_1.holster_offset = CFrame.new(0, 0, 1) * CFrame.Angles(0, 0, 1.5707963267948966)
tbl_upv_1.holster_part = "torso"
tbl_upv_1.magazine_hold_offset = CFrame.new(0.2, -2.225, 0) * CFrame.Angles(-1.5707963267948966, 0, 0)
tbl_upv_1.melee_range = 2.75
if RunService_1:IsServer() then
    return tbl_upv_1
end
local Input_upv_1 = require(game.ReplicatedStorage.Modules.Input)
local StateObject_upv_1 = require(game.ReplicatedStorage.Modules.StateObject)
local State_upv_1 = require(game.ReplicatedStorage.Modules.State)
local Event_upv_1 = require(game.ReplicatedStorage.Modules.Event)
local Util_upv_1 = require(game.ReplicatedStorage.Modules.Util)
local UI_upv_1 = require(game.ReplicatedStorage.Modules.UI)
local Globals_upv_1 = require(game.ReplicatedStorage.Modules.Globals)
local _ = require(game.ReplicatedStorage.Modules.Net)
local Data_upv_1 = require(game.ReplicatedStorage.Modules.Data)
local v1 = require(game.ReplicatedStorage.Modules.Items)
local FirstPersonInterface_upv_1 = require(game.ReplicatedStorage.Modules.FirstPersonInterface)
local FlagManager_upv_1 = require(game.ReplicatedStorage.Modules.FlagManager)
local Maid_upv_1 = require(game.ReplicatedStorage.Modules.Maid)
local Effects_upv_1 = require(game.ReplicatedStorage.Modules.Effects)
local v2 = game:GetService("UserInputService")
local Animations_upv_1 = require(script.Animations)
local Sounds_upv_1 = require(script.Sounds)
local tbl_2 = {}
local tbl_3 = {}
function tbl_3.__index(a1, a2)
    --[[
      name: __index
      line: 37
      upvalues:
        Animations_upv_1 (copy, index: 1)
        Parent_upv_1 (copy, index: 2)
    ]]
    return Animations_upv_1[a2] or (Parent_upv_1.anim[a2])
end
tbl_upv_1.anim = setmetatable(tbl_2, tbl_3)
local tbl_4 = {}
local tbl_5 = {}
function tbl_5.__index(a1, a2)
    --[[
      name: __index
      line: 42
      upvalues:
        Sounds_upv_1 (copy, index: 1)
        Parent_upv_1 (copy, index: 2)
    ]]
    return Sounds_upv_1[a2] or (Parent_upv_1.sound[a2])
end
tbl_upv_1.sound = setmetatable(tbl_4, tbl_5)
function tbl_upv_1.init(a1)
    --[[
      name: init
      line: 47
      upvalues:
        Util_upv_1 (copy, index: 1)
        State_upv_1 (copy, index: 2)
    ]]
    a1.auto_shoot_dt = os.clock()
    a1.last_shot = os.clock()
    a1.shot = a1:setup_shot(a1.instance:WaitForChild("Root"):FindFirstChild("Shoot", true))
    a1.accuracy = Instance.new("NumberValue")
    a1.reload_thread = Util_upv_1.ov(a1.reload_begin)
    a1.reload_thread:done(a1.reload_done)
    a1.reload_thread:cancelled(a1.reload_cancel)
    a1.cock_thread = Util_upv_1.ov(a1.cock_begin)
    a1.cock_thread:done(a1.cock_done)
    a1.cock_thread:cancelled(a1.cock_cancel)
    a1.recoil = Util_upv_1.ov(a1.recoil_function)
    a1.sights = Util_upv_1.ov(a1.sights)
    a1.sights:cancelled(
        function()
            --[[
              line: 60
              upvalues:
                a1 (copy, index: 1)
            ]]
            a1.owner.values.cframes:get("arm1"):remove_offset("sights")
            a1.owner.values.cframes:get("arm2"):remove_offset("sights")
            a1.cframes:get(a1.instance.Root):remove_offset("sights")
        end
    )
    a1.flash = Util_upv_1.ov(a1.flash)
    a1.safety_function = Util_upv_1.bf(a1.safety_function)
    a1.kickback = Util_upv_1.ov(a1.kickback)
    a1.safety = State_upv_1.new(nil)
    a1:load_instance()
end
function tbl_upv_1.flash(a1)
    --[[
      name: flash
      line: 76
    ]]
    a1.shot.Flash:Emit(3)
    a1.shot.Light.Enabled = true
    task.wait(0.05)
    a1.shot.Light.Enabled = false
end
function tbl_upv_1.set_part_pivots(a1)
    --[[
      name: set_part_pivots
      line: 83
      upvalues:
        Util_upv_1 (copy, index: 1)
    ]]
    a1.slide = a1.instance:FindFirstChild("Slide")
    if a1.slide then
        local v1 = a1.cframes:get(a1.slide, true)
        local u1 = a1.instance.Root.CFrame:ToObjectSpace(a1.slide:GetPivot())
        v1:set_pivot(
            "general",
            function()
                --[[
                  line: 88
                  upvalues:
                    a1 (copy, index: 1)
                    u1 (copy, index: 2)
                ]]
                return a1.instance.Root.CFrame * u1
            end
        )
        if a1.shoot_slide then
            a1.cframes:get(a1.slide):set_offset("shoot")
        end
    end
    a1.load_slide = a1.instance:FindFirstChild("LoadSlide") or a1.instance:FindFirstChild("Pump")
    if a1.load_slide then
        local v3 = a1.cframes:get(a1.load_slide, true)
        local u2 = a1.instance.Root.CFrame:ToObjectSpace(a1.load_slide:GetPivot())
        v3:set_pivot(
            "general",
            function()
                --[[
                  line: 100
                  upvalues:
                    a1 (copy, index: 1)
                    u2 (copy, index: 2)
                ]]
                return a1.instance.Root.CFrame * u2
            end
        )
        if a1.shoot_slide then
            a1.cframes:get(a1.load_slide):set_offset("shoot")
        end
    end
    a1.hammer = a1.instance:FindFirstChild("Hammer")
    if a1.hammer then
        local v4 = a1.cframes:get(a1.hammer, true)
        local u3 = a1.instance.Root.CFrame:ToObjectSpace(a1.hammer.CFrame)
        v4:set_pivot(
            "general",
            function()
                --[[
                  line: 112
                  upvalues:
                    a1 (copy, index: 1)
                    u3 (copy, index: 2)
                ]]
                return a1.instance.Root.CFrame * u3
            end
        )
    end
    a1.feed_cover = a1.instance:FindFirstChild("FeedCover")
    if a1.feed_cover then
        local v5 = a1.cframes:get(a1.feed_cover, true)
        local u4 = a1.instance.Root.CFrame:ToObjectSpace(a1.feed_cover:GetPivot())
        v5:set_pivot(
            "general",
            function()
                --[[
                  line: 121
                  upvalues:
                    a1 (copy, index: 1)
                    u4 (copy, index: 2)
                ]]
                return a1.instance.Root.CFrame * u4
            end
        )
        v5:set_offset("reload")
    end
    a1.cylinder = a1.instance:FindFirstChild("Cylinder")
    if a1.cylinder then
        local v6 = a1.cframes:get(a1.cylinder, true)
        local u5 = a1.instance.Root.CFrame:ToObjectSpace(a1.cylinder:GetPivot())
        v6:set_pivot(
            "general",
            function()
                --[[
                  line: 131
                  upvalues:
                    a1 (copy, index: 1)
                    u5 (copy, index: 2)
                ]]
                return a1.instance.Root.CFrame * u5
            end
        )
        v6:set_offset("reload")
        if a1.cylinder_loader then
            a1.loader = a1.cylinder_loader:Clone()
            a1.cframes:get(a1.loader.Case):set_pivot(
                "general",
                function(a2)
                    --[[
                      line: 138
                      upvalues:
                        a1 (copy, index: 1)
                    ]]
                    return (a1.owner.values.viewmodels.arm2.CFrame * CFrame.new(0.2, -0.7, -0.4)) * CFrame.Angles(-1.5707963267948966, 0.5235987755982988, 0) * CFrame.Angles(0, 0, -0.5235987755982988)
                end
            )
            a1.cframes:get(a1.loader.Case):create_pivot(
                "reload",
                function(a3)
                    --[[
                      line: 141
                      upvalues:
                        a1 (copy, index: 1)
                    ]]
                    return a1.instance.Cylinder:GetPivot() * CFrame.new(0, 0, 0.2)
                end
            )
        end
    end
    Util_upv_1.weld_c(a1.instance.Trigger, a1.instance.Root)
    a1.magazine = a1.instance:FindFirstChild("Magazine")
    if a1.magazine then
        local v7 = a1.cframes:get(a1.magazine)
        local u6 = a1.instance.Root.CFrame:ToObjectSpace(a1.magazine:GetPivot())
        v7:set_pivot(
            "general",
            function()
                --[[
                  line: 158
                  upvalues:
                    a1 (copy, index: 1)
                    u6 (copy, index: 2)
                ]]
                return a1.instance.Root.CFrame * u6
            end
        )
        v7:create_pivot(
            "reload",
            function(a4)
                --[[
                  line: 161
                  upvalues:
                    a1 (copy, index: 1)
                ]]
                return a1.owner.values.viewmodels.arm2:GetPivot() * a1.magazine_hold_offset
            end
        )
    end
    a1.end_bullet = a1.instance:FindFirstChild("EndBullet")
    if a1.end_bullet then
        local v8 = a1.cframes:get(a1.end_bullet, true)
        local u7 = a1.instance.Root.CFrame:ToObjectSpace(a1.end_bullet:GetPivot())
        v8:set_pivot(
            "general",
            function()
                --[[
                  line: 170
                  upvalues:
                    a1 (copy, index: 1)
                    u7 (copy, index: 2)
                ]]
                return a1.instance.Root.CFrame * u7
            end
        )
        v8:create_pivot(
            "unloaded",
            function()
                --[[
                  line: 173
                  upvalues:
                    a1 (copy, index: 1)
                ]]
                return a1.magazine.CFrame
            end
        )
    end
end
function tbl_upv_1.update_sight_lens(a1, a2)
    --[[
      name: update_sight_lens
      line: 179
      upvalues:
        Util_upv_1 (copy, index: 1)
        UI_upv_1 (copy, index: 2)
    ]]
    local v9 = a1.states.ads:get()
    local v10, v11, v12, v13 = nil, nil, nil, nil
    if a2 then
        local CurrentCamera_1 = workspace.CurrentCamera
        Util_upv_1.tween(CurrentCamera_1, TweenInfo.new(v9, Enum.EasingStyle.Linear), {FieldOfView = CurrentCamera_1:GetAttribute("OriginalFOV") / a1.states.zoom:get()})
        local tbl_6 = {Transparency = 1}
        Util_upv_1.tween(UI_upv_1.get("RedDot").UIStroke, TweenInfo.new(0.3), tbl_6)
        v10 = a1.instance:FindFirstChild("ScopePart", true)
        if v10 then
            v10:SetAttribute("OriginalMaterial", v10.Material.Name)
            if v10.Material ~= Enum.Material.Neon then
                v10.Material = Enum.Material.Glass
            end
            v10:SetAttribute("PreviousScopeTransparency", v10.Transparency)
            v10.Transparency = math.max(0.011, v10.Transparency)
        end
        v11 = a1.instance:FindFirstChild("ScopeTint", true)
        if v11 then
            v11.Transparency = ((v10 == nil) and 0.8) or 0.3
        end
        UI_upv_1.hook_world_billboards(
            "sights",
            function(a3)
                --[[
                  line: 201
                  upvalues:
                    Util_upv_1 (copy, index: 1)
                ]]
                Util_upv_1.tween(a3, TweenInfo.new(0.1), {GroupTransparency = 0.7, Size = UDim2.fromScale(0.9, 0.9)})
            end
        )
    else
        local CurrentCamera_2 = workspace.CurrentCamera
        Util_upv_1.tween(CurrentCamera_2, TweenInfo.new(v9, Enum.EasingStyle.Linear), {FieldOfView = CurrentCamera_2:GetAttribute("OriginalFOV")})
        local tbl_7 = {Transparency = 0.5}
        Util_upv_1.tween(UI_upv_1.get("RedDot").UIStroke, TweenInfo.new(0.3), tbl_7)
        v12 = a1.instance:FindFirstChild("ScopePart", true)
        if v12 and v12:GetAttribute("OriginalMaterial") then
            v12.Material = Enum.Material[v12:GetAttribute("OriginalMaterial")]
            v12.Transparency = v12:GetAttribute("PreviousScopeTransparency") or 0
        end
        v13 = a1.instance:FindFirstChild("ScopeTint", true)
        if v13 then
            v13.Transparency = 1
        end
        UI_upv_1.unhook_world_billboards("sights")
        for _, value_1 in UI_upv_1.get_world_billboards() do
            Util_upv_1.tween(value_1, TweenInfo.new(0.1), {GroupTransparency = 0, Size = UDim2.fromScale(1, 1)})
        end
    end
end
function tbl_upv_1.hook_states(a1)
    --[[
      name: hook_states
      line: 227
      upvalues:
        Maid_upv_1 (copy, index: 1)
        Util_upv_1 (copy, index: 2)
        UI_upv_1 (copy, index: 3)
    ]]
    a1.offsets = {}
    a1.states.mag:hook(
        function(a2)
            --[[
              line: 230
              upvalues:
                a1 (copy, index: 1)
            ]]
            a1:update_ui()
        end
    )
    a1.states.bullets:hook(
        function(a3)
            --[[
              line: 234
              upvalues:
                a1 (copy, index: 1)
            ]]
            a1:update_ui()
        end
    )
    a1.states.sights:hook(
        function(a4, a5)
            --[[
              line: 238
              upvalues:
                a1 (copy, index: 1)
            ]]
            if a4 == a5 then
                return
            end
            if a1.owner then
                a1:sights(a1.owner, a4)
            end
        end
    )
    a1.states.sights:hook(
        function(a6, a7)
            --[[
              line: 245
              upvalues:
                a1 (copy, index: 1)
            ]]
            if a6 == a7 then
                return
            end
            if a1.owner.values.camera:get() then
                a1:update_sight_lens(a6)
            end
        end
    )
    a1.states.reload:hook_paused(
        function(a8, a9)
            --[[
              line: 252
              upvalues:
                a1 (copy, index: 1)
            ]]
            if a8 == a9 then
                return
            end
            if a1.owner then
                a1:reload(a1.owner, false)
            end
        end
    )
    a1.states.reload:hook(
        function()
            --[[
              line: 259
              upvalues:
                a1 (copy, index: 1)
            ]]
            if not a1.owner then
                return
            end
            a1:reload(a1.owner, true)
        end
    )
    a1.states.accuracy:hook(
        function(a10)
            --[[
              line: 265
              upvalues:
                a1 (copy, index: 1)
            ]]
            if not a1.accuracy then
                return
            end
            a1.accuracy.Value = a1.states.accuracy:get() - 1
        end
    )
    a1.states.cock:hook(
        function()
            --[[
              line: 271
              upvalues:
                a1 (copy, index: 1)
            ]]
            if not a1.owner then
                return
            end
            a1:cock(a1.owner, true)
        end
    )
    a1.states.melee:hook(
        function()
            --[[
              line: 277
              upvalues:
                a1 (copy, index: 1)
            ]]
            if not a1.owner then
                return
            end
            a1:melee(a1.owner)
        end
    )
    a1.states.shoot:hook(
        function(a11, a12)
            --[[
              line: 283
              upvalues:
                a1 (copy, index: 1)
            ]]
            if not a1.owner then
                return
            end
            a1:shoot(a1.owner, a11, a12)
        end
    )
    a1.states.hit:hook(
        function(a13, a14)
            --[[
              line: 289
              upvalues:
                a1 (copy, index: 1)
            ]]
            if not a1.owner then
                return
            end
            a1:hit(a1.owner, a13, a14)
        end
    )
    a1.states.loaded:hook(
        function(a15, a16)
            --[[
              line: 295
              upvalues:
                a1 (copy, index: 1)
            ]]
            if a15 == a16 or not a1.owner then
                return
            end
            if a15 then
                if a16 ~= false then
                    if a16 then
                        local v14 = a1.instance:FindFirstChild("BulletEject", true)
                        local v15 = a1.states.mag:get()
                        local u8 = math.max(0, v15 - ((v14 and 1) or 0))
                        a1.states.mag:update(
                            function(a17)
                                --[[
                                  line: 308
                                  upvalues:
                                    u8 (copy, index: 1)
                                ]]
                                return a17 - u8
                            end
                        )
                        a1.states.bullets:update(
                            function(a18)
                                --[[
                                  line: 311
                                  upvalues:
                                    u8 (copy, index: 1)
                                ]]
                                return a18 + u8
                            end
                        )
                    end
                elseif a1.states.single_load:get() then
                    if a16 then
                        local v14 = a1.instance:FindFirstChild("BulletEject", true)
                        local v15 = a1.states.mag:get()
                        local u8 = math.max(0, v15 - ((v14 and 1) or 0))
                        a1.states.mag:update(
                            function(a17)
                                --[[
                                  line: 308
                                  upvalues:
                                    u8 (copy, index: 1)
                                ]]
                                return a17 - u8
                            end
                        )
                        a1.states.bullets:update(
                            function(a18)
                                --[[
                                  line: 311
                                  upvalues:
                                    u8 (copy, index: 1)
                                ]]
                                return a18 + u8
                            end
                        )
                    end
                else
                    local u9 = math.min(a1.states.mag_size:get(), a1.states.bullets:get())
                    a1.states.mag:update(
                        function(a19)
                            --[[
                              line: 299
                              upvalues:
                                u9 (copy, index: 1)
                            ]]
                            return a19 + u9
                        end
                    )
                    a1.states.bullets:update(
                        function(a20)
                            --[[
                              line: 302
                              upvalues:
                                u9 (copy, index: 1)
                            ]]
                            return a20 - u9
                        end
                    )
                    return
                end
            elseif a16 then
                local v14 = a1.instance:FindFirstChild("BulletEject", true)
                local v15 = a1.states.mag:get()
                local u8 = math.max(0, v15 - ((v14 and 1) or 0))
                a1.states.mag:update(
                    function(a17)
                        --[[
                          line: 308
                          upvalues:
                            u8 (copy, index: 1)
                        ]]
                        return a17 - u8
                    end
                )
                a1.states.bullets:update(
                    function(a18)
                        --[[
                          line: 311
                          upvalues:
                            u8 (copy, index: 1)
                        ]]
                        return a18 + u8
                    end
                )
            end
        end
    )
    a1.states.load_bullet:hook(
        function()
            --[[
              line: 317
              upvalues:
                a1 (copy, index: 1)
            ]]
            if not a1.owner or not a1.states.single_load:get() then
                return
            end
            a1.states.mag:update(
                function(a21)
                    --[[
                      line: 320
                    ]]
                    return a21 + 1
                end
            )
            a1.states.bullets:update(
                function(a22)
                    --[[
                      line: 323
                    ]]
                    return a22 - 1
                end
            )
        end
    )
    a1.states.chambered:hook(
        function(a23, a24)
            --[[
              line: 329
              upvalues:
                a1 (copy, index: 1)
            ]]
            if a23 == a24 then
                return
            end
            if a1.owner then
                a1:chamber(a1.owner, a23)
            end
        end
    )
    a1:hook_attachment_states()
    a1.safety:hook(
        function(a25, a26)
            --[[
              line: 338
              upvalues:
                a1 (copy, index: 1)
            ]]
            if not a1.owner then
                return
            end
            a1:safety_function(a1.owner, a25, a26)
        end
    )
    local u10 = Maid_upv_1.new()
    a1.object:destroying(
        function()
            --[[
              line: 346
              upvalues:
                u10 (copy, index: 1)
            ]]
            u10:clean()
        end
    )
    u10:add(
        a1.owner.values.camera:hook(
            function(a27, a28)
                --[[
                  line: 350
                  upvalues:
                    a1 (copy, index: 1)
                ]]
                if not a1.states.sights:get() then
                    return
                end
                if a27 then
                    a1:update_sight_lens(true)
                elseif a28 then
                    a1:update_sight_lens(false)
                end
            end
        ).unhook
    )
    u10:add(
        a1.owner.values.camera:hook(
            function(a29, a30)
                --[[
                  line: 359
                  upvalues:
                    a1 (copy, index: 1)
                    Util_upv_1 (copy, index: 2)
                    UI_upv_1 (copy, index: 3)
                ]]
                if not a1.states.sights:get() then
                    return
                end
                if a29 == game.Workspace.CurrentCamera then
                    local tbl_8 = {Transparency = 1}
                    Util_upv_1.tween(UI_upv_1.get("RedDot").UIStroke, TweenInfo.new(0), tbl_8)
                    local CurrentCamera_3 = workspace.CurrentCamera
                    Util_upv_1.tween(CurrentCamera_3, TweenInfo.new(0, Enum.EasingStyle.Linear), {FieldOfView = CurrentCamera_3:GetAttribute("OriginalFOV") / a1.states.zoom:get()})
                elseif a29 == nil and a30 == game.Workspace.CurrentCamera then
                    local CurrentCamera_4 = workspace.CurrentCamera
                    Util_upv_1.tween(CurrentCamera_4, TweenInfo.new(0, Enum.EasingStyle.Linear), {FieldOfView = CurrentCamera_4:GetAttribute("OriginalFOV")})
                end
            end
        ).unhook
    )
end
function tbl_upv_1.running(a1, a2, a3)
    --[[
      name: running
      line: 374
    ]]
    local v16 = a2.values.cframes:get("arms"):get_offset("run")
    if a3 then
        a1:running_pivots(a2, true)
        a1.states.sights:set(false)
        a1:reload(a2, false)
        a1.anim.Run.run_offset(v16)
    else
        a1:running_pivots(a2, false)
    end
end
function tbl_upv_1.sights(a1, a2, a3)
    --[[
      name: sights
      line: 388
      upvalues:
        Data_upv_1 (copy, index: 1)
        Input_upv_1 (copy, index: 2)
        Util_upv_1 (copy, index: 3)
        UI_upv_1 (copy, index: 4)
    ]]
    a1.sound.Handle(a1.instance.Root)
    local v17 = a2.values.cframes:get("arm1"):get_offset("sights")
    local v18 = a2.values.cframes:get("arm2"):get_offset("sights")
    local v19 = a1.cframes:get(a1.instance.Root):get_offset("sights")
    local v20 = a1.states.ads:get()
    if a3 then
        local v21 = false
        if a2.values.holding and a2.values.holding.safety then
            v20 = ((a2.values.holding.states.ads) and (v20 + a2.values.holding.states.ads:get())) or v20
            if a2.states.holding:get() == a2.values.holding.instance then
                a2.values.holding.safety:set(true)
                v21 = true
            end
        end
        a1:reload(a2, false)
        a2.values.cframes:get("arm1"):set_offset("sights")
        if not (v21) then
            a2.values.cframes:get("arm2"):set_offset("sights")
        end
        a1.anim.Equip.arm1_hold(a2.values.cframes:get("arm1"):set_absolute("sights", true), a1, v20)
        a1.cframes:get(a1.instance.Root):set_offset("sights")
        a1.anim.Sight.arm1(v17, a1.instance, v20)
        a1.anim.Sight.arm2(v18, a1.instance, v20)
        a1.anim.Sight.gun(v19, a1.instance, v20)
        if a2.values.camera:get() then
            if a1.inputs and a1.inputs.enabled:get() then
                local v22 = ("camera_sensitivity_%*"):format(string.gsub(tostring(a1.states.zoom:get()), "[.]", "_"))
                if Data_upv_1.settings[v22] then
                    Input_upv_1.mouse_base_sensitivity:set(Util_upv_1.map_sensitivity(Data_upv_1.settings[v22]))
                    task.spawn(
                        function()
                            --[[
                              line: 441
                              upvalues:
                                a1 (copy, index: 1)
                                Input_upv_1 (copy, index: 2)
                                Util_upv_1 (copy, index: 3)
                                Data_upv_1 (copy, index: 4)
                            ]]
                            while a1.states.sights:get() do
                                a1.states.sights:wait()
                            end
                            Input_upv_1.mouse_base_sensitivity:set(Util_upv_1.map_sensitivity(Data_upv_1.settings.camera_sensitivity))
                        end
                    )
                end
            end
            local tbl_9 = {Value = 1}
            Util_upv_1.tween(a1.accuracy, TweenInfo.new(v20, Enum.EasingStyle.Linear), tbl_9)
        end
    else
        a2.values.cframes:get("arm1"):remove_absolute("sights")
        if a2.values.holding and a2.values.holding.safety then
            local v23 = a2.values.equip_debounce:get()
            if not (v23) then
                a2.values.holding.safety:set(false)
                v20 = ((a2.values.holding.states.ads) and (v20 + a2.values.holding.states.ads:get())) or v20
            end
        end
        if a2.values.camera:get() then
            Util_upv_1.tween(a1.accuracy, TweenInfo.new(v20, Enum.EasingStyle.Linear), {Value = a1.states.accuracy:get() - 1})
        end
        if a1.inputs and a1.inputs.enabled:get() then
            UI_upv_1.get("CancelScope").Visible = false
        end
        a1.anim.Sight.base(v19, a1.instance, v20)
        a1.anim.Sight.base(v18, a1.instance, v20)
        a1.anim.Sight.base(v17, a1.instance, v20).Completed:Wait()
        if v17.Value == CFrame.new() then
            a2.values.cframes:get("arm1"):remove_offset("sights")
            a2.values.cframes:get("arm2"):remove_offset("sights")
        end
        a1.cframes:get(a1.instance.Root):remove_offset("sights")
    end
end
function tbl_upv_1.reload(a1, a2, a3)
    --[[
      name: reload
      line: 491
    ]]
    if a3 then
        a1.reload_thread(a1, a2, a3)
    else
        a1.reload_thread:cancel(a1, a2, a3)
    end
end
function tbl_upv_1.cock(a1, a2, a3)
    --[[
      name: cock
      line: 499
    ]]
    if a3 then
        a1:reload(a2, false)
        a1.cock_thread(a1, a2, a3)
    else
        a1.cock_thread:cancel(a1, a2, a3)
    end
end
function tbl_upv_1.chamber(a1, a2, a3)
    --[[
      name: chamber
      line: 508
    ]]
    if a1.slide then
        local v24 = a1.cframes:get(a1.slide):get_offset("shoot")
        if a3 then
            a1.anim.Gun.slide_off(v24)
        else
            a1.anim.Gun.slide_on(v24).Completed:Wait()
        end
    end
    if (a1.states.single_load:get()) then
        return
    end
    if a3 then
        a1.sound.Reload4(a1.instance.Root)
    else
        a1.sound.Empty(a1.instance.Root)
    end
end
function tbl_upv_1.render(a1, a2, a3)
    --[[
      name: render
      line: 526
    ]]
    a1.instance.Root:PivotTo(a1.cframes:get(a1.instance.Root):render(a3))
    if a1.hammer then
        a1.hammer:PivotTo(a1.cframes:get(a1.hammer):render(a3))
    end
    if a1.feed_cover then
        a1.feed_cover:PivotTo(a1.cframes:get(a1.feed_cover):render(a3))
    end
    if a1.slide then
        a1.slide:PivotTo(a1.cframes:get(a1.slide):render(a3))
    end
    if a1.load_slide then
        a1.load_slide:PivotTo(a1.cframes:get(a1.load_slide):render(a3))
    end
    if a1.magazine then
        a1.magazine:PivotTo(a1.cframes:get(a1.magazine):render(a3))
    elseif a1.cylinder then
        a1.cylinder:PivotTo(a1.cframes:get(a1.cylinder):render(a3))
        if a1.loader and a1.loader.Parent == a2.values.viewmodels then
            a1.loader.Case:PivotTo(a1.cframes:get(a1.loader.Case):render(a3))
        end
    end
    if a1.end_bullet then
        a1.end_bullet:PivotTo(a1.cframes:get(a1.end_bullet):render(a3))
    end
    if a1.charm_model and a1.charm_model.PrimaryPart then
        a1.charm_model.PrimaryPart:PivotTo(a1.cframes:get(a1.charm_model.PrimaryPart):render(a3))
    end
    if not a1.inputs or not a1.inputs.enabled:get() then
        return
    end
    a1:input_render(a3)
end
function tbl_upv_1.auto_shoot_check(a1, a2)
    --[[
      name: auto_shoot_check
      line: 569
      upvalues:
        UI_upv_1 (copy, index: 1)
        Util_upv_1 (copy, index: 2)
        StateObject_upv_1 (copy, index: 3)
    ]]
    local v25 = os.clock()
    if not (v25 - a1.auto_shoot_dt > 0.25) then
        return
    end
    a1.auto_shoot_dt = v25
    if UI_upv_1.get("Flash").Frame.BackgroundTransparency == 0 then
        return
    end
    local owner_1 = a1.owner
    local v26 = a1:get_shoot_look()
    local v27 = CFrame.new(Util_upv_1.validate_position(game.Workspace.CurrentCamera.CFrame.Position, v26.Position, owner_1.values.ray_params)) * v26.Rotation
    for _, value_2 in a1:ray_damage(v27.Position, v27.LookVector * 500, {owner_1.values.viewmodels, owner_1.instance}, nil, true) do
        local Instance_1 = value_2.Instance
        if not value_2.HitHum then
            if not (Instance_1) or not (Instance_1.Transparency < 1) then
                continue
            end
            local v28 = Util_upv_1.get_breakable_instance(Instance_1)
            if not (v28) or Util_upv_1.ownership(StateObject_upv_1.get("Breakable", v28).owner:get()) ~= 0 then
                continue
            end
        end
        a1:input_shoot(true)
        return
    end
    if not a1.shoot_hold or a1.inputs:get("shoot"):holding() or a1.inputs:get("shoot_joystick"):holding() then
        return
    end
    a1:input_shoot(false)
end
function tbl_upv_1.input_render(a1, a2)
    --[[
      name: input_render
      line: 608
      upvalues:
        Data_upv_1 (copy, index: 1)
    ]]
    local owner_2 = a1.owner
    if owner_2.values.prone_debounce or owner_2.values.equip_debounce:get() or owner_2.states.vault:get() > 0 then
        a1:reload(owner_2, false)
        a1:cock(owner_2, false)
    elseif not (a1.cock_thread.running) and not (a1.reload_thread.running) and not (a1.states.chambered:get()) and not (owner_2.values.equip_debounce:get()) and not (a1.states.reload:get()) and owner_2.states.vault:get() == 0 and a1.states.loaded:get() and a1.states.mag:get() > 0 then
        a1.states.cock:fire_instant()
    end
    if not (Data_upv_1.settings.toggle_aim) then
        if a1.ads_hold then
            if a1.reload_thread.running or a1.meleeing or owner_2.states.running:get() or owner_2.values.prone_debounce or owner_2.values.equip_debounce:get() then
                a1.states.sights:set(false)
            else
                a1.states.sights:set(true)
            end
        else
            a1.states.sights:set(false)
        end
    end
    if a1.automatic and (a1.shoot_hold and a1.burst == nil or a1.burst_left and a1.burst_left > 0) then
        if a1.safety:get() and not (a1.accuracy.Value >= 1) or owner_2.values.equip_debounce:get() then
            if a1.states.reload:get() and owner_2.values.equip_debounce:get() then
                a1:reload(owner_2, false)
            end
            return
        end
        local v29, v30 = nil, nil
        if not (owner_2.states.running:get()) then
            v29 = os.clock()
            v30 = a1.states.firerate:get()
            if v30 == 0 or 1 / (v30 / 60) < v29 - a1.last_shot then
                if (a1.states.mag:get() > 0) and (a1.states.chambered:get()) then
                    a1.last_shot = v29
                    a1:send_shoot()
                    if a1.burst_left then
                        a1.burst_left = a1.burst_left - 1
                    end
                else
                    a1.burst_left = 0
                end
            end
        end
    end
    if not a1.states.reload:get() or not owner_2.values.equip_debounce:get() then
        return
    end
    a1:reload(owner_2, false)
end
function tbl_upv_1.kickback(a1, a2)
    --[[
      name: kickback
      line: 657
    ]]
    local v31 = a2.values.cframes:get("arms"):set_offset("shoot")
    a1.anim.Shoot.key1(v31).Completed:Wait()
    a1.anim.Shoot.key2(v31).Completed:Wait()
    a1.anim.Shoot.key3(v31).Completed:Wait()
    a2.values.cframes:get("arms"):remove_offset("shoot")
end
function tbl_upv_1.recoil_function(a1, a2)
    --[[
      name: recoil_function
      line: 668
      upvalues:
        Input_upv_1 (copy, index: 1)
        Util_upv_1 (copy, index: 2)
    ]]
    a2.values.cframes:get("camera"):remove_offset("shoot")
    local v32 = a2.values.cframes:get("camera"):set_offset("shoot")
    local Value_1 = v32.Value
    if a2.values.camera:get() then
        local values_1 = a2.values
        values_1.old_cam_render = values_1.old_cam_render * Value_1:Inverse()
    end
    local v33 = a1.states.recoil_up:get()
    local v34 = a1.states.recoil_side:get()
    if Input_upv_1.current_device:get() ~= "pc" then
        v33 = v33 * 0.7
        v34 = v34 * 0.7
    end
    if a1.prone_recoil and a2.states.walk_state:get() == "prone" then
        v33 = v33 * a1.prone_recoil
        v34 = v34 * a1.prone_recoil
    end
    Util_upv_1.tween(v32, TweenInfo.new(0), {Value = CFrame.new()})
    v32.Value = CFrame.new()
    if a2.values.cframes:get("arm2"):current_pivot() ~= "equipped" then
        v34 = v34 * 1.2
    else
        v33 = v33 * 0.8
    end
    local v35 = CFrame.Angles(math.rad(Util_upv_1.rand(v33 * 1, v33 * 2)), math.rad(Util_upv_1.rand(-v34 * 1, v34 * 1)), 0)
    local v36 = math.exp((v33 + v34) / 30)
    local tbl_10 = {}
    tbl_10.Value = v35
    Util_upv_1.tween(v32, TweenInfo.new(math.max(math.min(0.1, 60 / a1.states.firerate:get()), v36 * 0.06), Enum.EasingStyle.Quad, Enum.EasingDirection.Out), tbl_10).Completed:Wait()
    local v37 = TweenInfo.new(v36 * 0.24, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tbl_11 = {}
    tbl_11.Value = CFrame.new()
    Util_upv_1.tween(v32, v37, tbl_11).Completed:Wait()
end
function tbl_upv_1.shoot(a1, a2, a3, a4) --shoot function
    --[[
      name: shoot
      line: 707
    ]]
    a1.states.mag:update(
        function(a5)
            --[[
              line: 708
            ]]
            return (math.max(0, a5 - 1))
        end
    )
    if a1.states.firerate:get() ~= 0 then
        local v38 = a1.instance:FindFirstChild("BulletEject", true)
        if v38 then
            a1:eject_bullet(v38, a1.bullet_type)
        end
    else
        a1.states.chambered:set(false)
    end
    if a1.supressed then
        a1.sound.SilencedShoot(a1.shot)
    else
        a1.sound.Shoot(a1.shot)
    end
    a1:reload(a2, false)
    local v39 = a1.states.pellets:get() > 1
    if a1.owner.values.camera:get() == nil and not (v39) and a4 and #a4 > 0 then
        for _, value_3 in a4 do
            if #value_3 > 0 then
                a1:trail(a1.shot.CFrame.Position, value_3[#value_3].Position)
            end
        end
    end
    task.spawn(
        function()
            --[[
              line: 734
              upvalues:
                a1 (copy, index: 1)
                a2 (copy, index: 2)
            ]]
            a1:kickback(a2)
        end
    )
    if a2.values.camera:get() then
        a1.recoil(a1, a2)
    end
    task.spawn(
        function()
            --[[
              line: 740
              upvalues:
                a1 (copy, index: 1)
            ]]
            local Smoke_1 = a1.shot:FindFirstChild("Smoke")
            if not Smoke_1 then
                return
            end
            for _ = 1, 3 do
                Smoke_1:Emit(1)
                task.wait(0.1)
            end
        end
    )
    if a1.shot:FindFirstChild("Flash") then
        a1:flash()
    end
    if a1.states.firerate:get() > 0 then
        task.spawn(a1.slide_shoot, a1)
    end
    if a1.hammer then
        task.spawn(
            function()
                --[[
                  line: 756
                  upvalues:
                    a1 (copy, index: 1)
                ]]
                local v40 = a1.cframes:get(a1.hammer):set_offset("shoot")
                a1.anim.Gun.hammer_on(v40).Completed:Wait()
                a1.anim.Gun.hammer_off(v40).Completed:Wait()
                a1.cframes:get(a1.hammer):remove_offset("shoot")
            end
        )
    end
    if not a4 then
        return
    end
    a1:bullet_hit(a2, a4)
end
function tbl_upv_1.bullet_hit(a1, a2, a3)
    --[[
      name: bullet_hit
      line: 775
      upvalues:
        Util_upv_1 (copy, index: 1)
        Effects_upv_1 (copy, index: 2)
        Maid_upv_1 (copy, index: 3)
        StateObject_upv_1 (copy, index: 4)
    ]]
    for _, value_4 in a3 do
        if #value_4 == 0 then
            continue
        end
        local tbl_12 = {}
        for v46, value_5 in value_4 do
            local Instance_2 = value_5.Instance
            if Instance_2 == nil then
                continue
            end
            if not (Instance_2:HasTag("Water")) or Instance_2.CanCollide then
                if not (value_5.HitHum) or not (Instance_2.Parent) then
                    continue
                end
                if not (tbl_12[Instance_2.Parent]) then
                    tbl_12[Instance_2.Parent] = true
                    local v41 = Instance.new("Attachment")
                    v41.Parent = game.Workspace.Terrain
                    v41.WorldCFrame = CFrame.new(value_5.Position) * CFrame.lookAt(Vector3.new(0, 0, 0), value_5.Normal)
                    Util_upv_1.debris(v41, 1)
                    a1:emit_blood(v41, Instance_2.Color)
                    a1.sound.BulletHit(v41)
                    continue
                end
            end
            local Position_1 = value_5.Position
            local v42 = Instance.new("Attachment")
            Util_upv_1.debris(v42, 2)
            v42.WorldCFrame = CFrame.new(Position_1.X, Instance_2.CFrame.Y + (math.min(Instance_2.Size.X, Instance_2.Size.Y, Instance_2.Size.Z) * 0.5), Position_1.Z)
            v42.Parent = game.Workspace.Terrain
            Effects_upv_1.Ring(v42, Instance_2.Color)
            Effects_upv_1.Splash(v42, 3, Instance_2.Color)
            Effects_upv_1.WaterSplash(v42)
        end
        local v43 = value_4[#value_4]
        if not (v43) then
            continue
        end
        local Instance_3 = v43.Instance
        local v44 = v43.Normal
        local Position_2 = v43.Position
        if v43.HitHum or not (Instance_3) or not (Instance_3.Transparency < 1) or not (Instance_3.Anchored) then
            continue
        end
        local u11 = Effects_upv_1.create_point(Position_2, v44, math.random(8, 12))
        local u12 = Util_upv_1.get_breakable_instance(Instance_3)
        if u12 then
            local u13 = Maid_upv_1.new()
            u13:add(
                StateObject_upv_1.get("Breakable", u12).states.destroyed:hook(
                    function(a4)
                        --[[
                          line: 817
                          upvalues:
                            u11 (copy, index: 1)
                        ]]
                        if not a4 then
                            return
                        end
                        task.defer(
                            function()
                                --[[
                                  line: 819
                                  upvalues:
                                    u11 (copy, index: 1)
                                ]]
                                u11:Destroy()
                            end
                        )
                    end
                ).unhook
            )
            u13:add(
                u12.AncestryChanged:Connect(
                    function()
                        --[[
                          line: 825
                          upvalues:
                            u12 (copy, index: 1)
                            u11 (copy, index: 2)
                        ]]
                        if u12.Parent ~= nil and u12.Parent ~= game.ReplicatedStorage.Garbage then
                            return
                        end
                        task.defer(
                            function()
                                --[[
                                  line: 827
                                  upvalues:
                                    u11 (copy, index: 1)
                                ]]
                                u11:Destroy()
                            end
                        )
                    end
                )
            )
            u11.Destroying:Connect(
                function()
                    --[[
                      line: 833
                      upvalues:
                        u13 (copy, index: 1)
                    ]]
                    u13:clean()
                end
            )
        end
        local v45 = script.BulletHoles.Normal:Clone()
        v45.Parent = u11
        v45.Color = ColorSequence.new(Instance_3.Color)
        v45:Emit(2)
    end
end
function tbl_upv_1.slide_shoot(a1)
    --[[
      name: slide_shoot
      line: 847
    ]]
    if a1.slide then
        local v46 = a1.cframes:get(a1.slide):get_offset("shoot")
        a1.anim.Gun.slide_on(v46).Completed:Wait()
        if a1.states.mag:get() > 0 then
            a1.anim.Gun.slide_off(v46).Completed:Wait()
        end
        if a1.states.mag:get() ~= 0 then
            return
        end
        a1.states.chambered:set(false)
    elseif a1.load_slide then
        local v47 = a1.cframes:get(a1.load_slide):get_offset("shoot")
        a1.anim.Gun.slide_on(v47).Completed:Wait()
        a1.anim.Gun.slide_off(v47).Completed:Wait()
        if a1.states.mag:get() ~= 0 then
            return
        end
        a1.states.chambered:set(false)
    end
end
function tbl_upv_1.melee(a1, a2, a3)
    --[[
      name: melee
      line: 867
    ]]
    a1:reload(a2, false)
    a1:cock(a2, false)
    a1.meleeing = true
    local v48 = a2.values.cframes:get("arm1"):set_absolute("melee", true)
    local v49 = nil
    if a1.anim.Melee.arm2_hold then
        a1.anim.Melee.arm2_hold((a2.values.cframes:get("arm2"):set_absolute("melee", true)))
    else
        local _ = a2.values.cframes:get("arm2"):set_absolute("melee", CFrame.new())
        a2.values.cframes:get("arm2"):set_pivot("base")
    end
    if a1.anim.Melee.gun_hold then
        local v50 = a1.cframes:get(a1.instance.Root):set_absolute("melee", true)
        a1.anim.Melee.gun_hold(v50)
        v49 = v50
    end
    a1.sound.Handle(a1.instance.Root)
    a1.anim.Melee.arm1_hold(v48).Completed:Wait()
    a2.values.cframes:get("arm1"):remove_absolute("melee")
    a2.values.cframes:get("arm2"):remove_absolute("melee")
    if not (a1.anim.Melee.arm2_hold) then
        a2.values.cframes:get("arm2"):remove_pivot("base")
    end
    if not v49 then
        return
    end
    a1.cframes:get(a1.instance.Root):remove_absolute("melee")
end
function tbl_upv_1.hit(a1, a2, a3, a4)
    --[[
      name: hit
      line: 896
    ]]
    local v51 = a2.values.cframes:get("arm1"):set_absolute("melee")
    local v52 = nil
    local _ = (not (a1.anim.Melee.arm2_hit)) or (a2.values.cframes:get("arm2"):set_absolute("melee"))
    local v53 = (not (a1.anim.Melee.gun_hit)) or (a1.cframes:get(a1.instance.Root):set_absolute("melee"))
    if a1:process_hit_results(a3, a4) then
        a1.sound.Swing(a1.instance.Root)
        if v53 then
            a1.anim.Melee.gun_miss(v53)
        end
        if v52 then
            a1.anim.Melee.arm2_miss(v52)
        end
        a1.anim.Melee.arm1_miss(v51).Completed:Wait()
    else
        if v53 then
            a1.anim.Melee.gun_hit(v53)
        end
        if v52 then
            a1.anim.Melee.arm2_hit(v52)
        end
        a1.anim.Melee.arm1_hit(v51).Completed:Wait()
    end
    a2.values.cframes:get("arm1"):remove_absolute("melee")
    if v52 then
        a2.values.cframes:get("arm2"):remove_absolute("melee")
    end
    if nil then
        a1.cframes:get(a1.instance.Root):remove_absolute("melee")
    end
    a1.meleeing = false
end
function tbl_upv_1.safety_function(a1, a2, a3, a4)
    --[[
      name: safety_function
      line: 937
    ]]
    local v54 = a2.values.cframes:get("arm1"):get_absolute("equipped")
    local v55 = a2.values.cframes:get("arm2"):get_absolute("equipped")
    if a3 == true then
        a1.anim.Equip.arm1_hold_safety(v54)
        if a4 ~= false then
            return
        end
        a2.values.cframes:get("arm2"):remove_pivot("equipped")
        a2.values.cframes:get("arm2"):remove_absolute("equipped")
    elseif a3 == false then
        a2.values.cframes:get("arm2"):set_absolute("equipped", true)
        a2.values.cframes:get("arm2"):set_pivot("equipped")
        a1.anim.Equip.arm2_hold(v55, a1)
        a1.anim.Equip.arm1_hold(v54, a1).Completed:Wait()
    end
end
function tbl_upv_1.equip(a1, a2, a3)
    --[[
      name: equip
      line: 956
    ]]
    local v56 = a2.values.cframes:get("arm1"):get_absolute("equipped")
    local _ = a2.values.cframes:get("arm2"):get_absolute("equipped")
    local Root_1 = a1.instance:FindFirstChild("Root")
    if Root_1 == nil then
        return
    end
    if a3 ~= true then
        a1.states.sights:set(false)
        a1:reload(a2, false)
        a1:cock(a2, false)
        a1.sound.Handle(Root_1)
        a2.values.cframes:get("arm1"):remove_pivot("equipped")
        if a1.safety:get() == false then
            a2.values.cframes:get("arm2"):remove_pivot("equipped")
            a2.values.cframes:get("arm2"):remove_absolute("equipped")
        end
        a1.safety:set_instant(nil)
        if a2.values.holding and a2.values.holding.safety then
            a2.values.holding.safety:set(false)
        end
        a1.anim.Equip.arm1_grab(v56).Completed:Wait()
        a1.cframes:get(Root_1).pivot_time = 0.2
        a1.cframes:get(Root_1):remove_pivot("equipped")
        a2.values.cframes:get("arm1"):remove_absolute("equipped")
        a1:holster(a2)
    else
        a1:unholster(a2)
        a2.values.cframes:get("arm1"):set_absolute("equipped", true)
        a1.anim.Equip.arm1_grab(v56).Completed:Wait()
        a1.sound.Equip(Root_1)
        a1.cframes:get(Root_1):set_pivot("equipped")
        a1.cframes:get(Root_1).pivot_time = 0.2
        a2.values.cframes:get("arm1"):set_pivot("equipped")
        local safety_1 = a1.safety
        local v57 = a2.values.holding and ((a2.states.holding:get() == a2.values.holding.instance) and (a2.values.holding.loadout_type == "primary"))
        safety_1:set_instant(v57)
    end
end
function tbl_upv_1.trail(a1, a2, a3, a4)
    --[[
      name: trail
      line: 1008
      upvalues:
        Util_upv_1 (copy, index: 1)
    ]]
    local v58 = Instance.new("Attachment")
    local v59 = Instance.new("Attachment")
    Util_upv_1.debris(v58, 0.5)
    Util_upv_1.debris(v59, 0.5)
    v58.Parent = workspace.Terrain
    v59.Parent = workspace.Terrain
    v58.Position = a2
    v59.Position = a3
    local v60 = Instance.new("Beam", game.Workspace)
    Util_upv_1.debris(v60, 0.5)
    v60.Width0 = a1.states.trail_size:get() or 0.1
    v60.Width1 = a1.states.trail_size:get() or 0.1
    v60.Attachment0 = v58
    v60.Attachment1 = v59
    if a1.supressed then
        v60.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0.95)})
    else
        v60.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0.75)})
    end
    local tbl_13 = {Width0 = 0, Width1 = 0}
    Util_upv_1.tween(v60, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, false, 0), tbl_13)
    if a1.owner.values.camera:get() == nil then
        local v61 = Instance.new("Attachment")
        Util_upv_1.debris(v61, 0.5)
        v61.Parent = workspace.Terrain
        v61.WorldCFrame = CFrame.new(Util_upv_1.closest_point_on_segment(game.Workspace.CurrentCamera.CFrame.Position, v58.WorldCFrame.Position, v59.WorldCFrame.Position))
        local v62 = a1.sound.BulletWoosh(v61)
        v62.Volume = math.min(1, (a2 - a3).Magnitude / 50) * 0.5
    end
end
local u14 = Util_upv_1.create_debris_queue("casings", 16, 5)
function tbl_upv_1.eject_bullet(a1, a2, a3, a4)
    --[[
      name: eject_bullet
      line: 1055
      upvalues:
        Data_upv_1 (copy, index: 1)
        u14 (copy, index: 2)
        Effects_upv_1 (copy, index: 3)
    ]]
    if Data_upv_1.settings and not (Data_upv_1.settings.debris) then
        return
    end
    local v63 = script.Bullets[a3]:Clone()
    v63.Parent = workspace
    v63.CanCollide = true
    v63:PivotTo(a2.WorldCFrame)
    v63.AssemblyLinearVelocity = a2.WorldCFrame.RightVector * math.random(8, 12) + (a2.WorldCFrame.UpVector * math.random(8, 12))
    v63.CastShadow = false
    v63.CanQuery = false
    u14:add_item(v63)
    Effects_upv_1.mark_for_killcam(v63)
    return v63
end
function tbl_upv_1.setup_shot(a1, a2)
    --[[
      name: setup_shot
      line: 1075
      upvalues:
        Util_upv_1 (copy, index: 1)
    ]]
    local v64 = script.Shot:Clone()
    v64.Flash.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.3), NumberSequenceKeypoint.new(1, 0.3)})
    v64.Parent = a2.Parent
    v64.CFrame = a2.WorldCFrame
    Util_upv_1.weld_c(v64, a2.Parent)
    return v64
end
function tbl_upv_1.hide_mag(a1, a2)
    --[[
      name: hide_mag
      line: 1087
    ]]
    if a2 then
        a1.magazine.Parent = nil
    else
        a1.magazine.Parent = a1.instance
    end
end
function tbl_upv_1.reload_begin(a1, a2)
    --[[
      name: reload_begin
      line: 1101
      upvalues:
        Util_upv_1 (copy, index: 1)
    ]]
    a1.sound.Handle(a1.instance.Root)
    a1.safety:set(false)
    local v65 = a2.values.cframes:get("arm1"):set_absolute("reload", true)
    local v66 = a2.values.cframes:get("arm2"):set_absolute("reload", true)
    local v67 = a1.cframes:get(a1.instance.Root):set_absolute("reload", true)
    local v68 = a1.states.reload_speed:get()
    local v69 = false
    if a1.feed_cover then
        a1.anim.Reload.arm2_empty1(v66, v68)
        a1.anim.Reload.gun_empty1(v67, v68)
        a1.anim.Reload.arm1_empty1(v65, v68).Completed:Wait()
        local v70 = a1.cframes:get(a1.feed_cover):get_offset("reload")
        a1.sound.FeedOpen(a1.instance.Root)
        Util_upv_1.tween(v70, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Value = CFrame.Angles(0, -0.5235987755982988, 0)})
        a1.anim.Reload.arm2_empty2(v66, v68).Completed:Wait()
        if not (a1.states.loaded:get()) or a1.states.single_load:get() then
            a1.anim.Reload.gun(v67, v68)
        else
            a1.anim.Reload.arm1_start(v65, v68)
            a1.anim.Reload.gun(v67, v68)
            a1.anim.Reload.arm2_start(v66, v68).Completed:Wait()
            if a1.magazine then
                if a1.end_bullet then
                    a1.cframes:get(a1.end_bullet):set_pivot("unloaded")
                end
                a1.cframes:get(a1.magazine):set_pivot("reload")
                a1.sound.Reload1(a1.instance.Root)
                a1.states.loaded:set(false)
                v69 = true
            end
        end
    elseif a1.cylinder then
        a1.anim.Reload.arm1_start(v65, v68)
        a1.anim.Reload.gun(v67, v68)
        a1.anim.Reload.arm2_start(v66, v68).Completed:Wait()
        local v71 = a1.cframes:get(a1.cylinder):get_offset("reload")
        a1.sound.Reload1(a1.instance.Root)
        a1.anim.Reload.cylinder_open(v71, v68)
        local v72 = a1.states.loaded:get()
        if v72 then
            if a1.anim.Reload.arm1_empty1 then
                a1.anim.Reload.arm2_empty1(v66, v68)
                a1.anim.Reload.arm1_empty1(v65, v68).Completed:Wait()
            end
            if a1.cylinder:FindFirstChild("Eject") then
                for _ = 1, a1.states.mag_size:get() do
                    a1:eject_bullet(a1.cylinder.Eject, a1.bullet_type, CFrame.Angles(0, 1.5707963267948966, 1.5707963267948966))
                end
                a1.sound.Cases(a1.instance.Root)
            end
            a1.states.loaded:set(false)
            local v73 = true
            if a1.anim.Reload.arm1_empty2 then
                a1.anim.Reload.arm2_empty2(v66, v68)
                a1.anim.Reload.arm1_empty2(v65, v68).Completed:Wait()
            end
            v69 = v73
        end
    elseif not (a1.states.loaded:get()) or a1.states.single_load:get() then
        a1.anim.Reload.gun(v67, v68)
        if a1.magazine then
            if a1.end_bullet then
                a1.cframes:get(a1.end_bullet):set_pivot("unloaded")
            end
            a1.cframes:get(a1.magazine):set_pivot("reload")
            v69 = true
        end
    else
        a1:cock(a2, false)
        a1.anim.Reload.arm1_start(v65, v68)
        a1.anim.Reload.gun(v67, v68)
        a1.anim.Reload.arm2_start(v66, v68).Completed:Wait()
        if a1.magazine then
            if a1.end_bullet then
                a1.cframes:get(a1.end_bullet):set_pivot("unloaded")
            end
            a1.cframes:get(a1.magazine):set_pivot("reload")
            a1.sound.Reload1(a1.instance.Root)
            a1.states.loaded:set(false)
            v69 = true
        end
    end
    local v74 = a1.states.mag_size:get() - a1.states.mag:get()
    local v75
    if not (a1.states.chambered:get()) or a1.cylinder then
        v75 = 0
    else
        v75 = 1
    end
    local v76 = math.min(v74 + v75, a1.states.bullets:get())
    if v76 > 0 then
        a1:cock(a2, false)
    end
    for n_1 = 1, v76 do
        a1.anim.Reload.arm1_idle1(v65, v68)
        if v69 and a1.anim.Reload.arm2_start2 then
            a1.anim.Reload.arm2_start2(v66, v68).Completed:Wait()
        end
        a2.values.cframes:get("arm2"):set_pivot("reload")
        a1.anim.Reload.base(v66, v68)
        if a1.anim.Reload.gun_idle then
            a1.anim.Reload.gun_idle(v67, v68)
        end
        if a1.states.single_load:get() then
            task.wait(0.15 * v68)
            a1.single_bullet = script.Bullets[a1.bullet_load_type or (a1.bullet_type)]:Clone()
            a1.single_bullet.Parent = a2.values.viewmodels
            a1.single_bullet.CanCollide = false
            a1.single_bullet:PivotTo(a2.values.viewmodels.arm2.CFrame * a1.hold_bullet_offset)
            Util_upv_1.weld_c(a1.single_bullet, a2.values.viewmodels.arm2)
        else
            task.wait(0.5 * v68)
            if a1.cylinder and a1.loader then
                a1.loader.Bullets.Transparency = 0
                a1.loader.Parent = a2.values.viewmodels
                a1.loader.Case:PivotTo(a1.cframes:get(a1.loader.Case):render(0.016666666666666666))
            end
        end
        a2.values.cframes:get("arm2"):remove_pivot("reload")
        a1.anim.Reload.arm1_idle2(v65, v68)
        a1.anim.Reload.arm2_idle(v66, v68).Completed:Wait()
        if a1.magazine then
            a1.cframes:get(a1.magazine):remove_pivot("reload")
            a1:hide_mag(false)
            a1.sound.Reload2(a1.instance.Root)
            if a1.feed_cover then
                a1.anim.Reload.arm2_finish(v66, v68)
                a1.anim.Reload.arm1_finish(v65, v68).Completed:Wait()
                a1.sound.Chains(a1.instance.Root)
                if a1.end_bullet then
                    a1.cframes:get(a1.end_bullet):remove_pivot("unloaded")
                    a1.end_bullet.Transparency = 0
                    for _, value_6 in a1.end_bullet:GetChildren() do
                        if value_6:IsA("BasePart") then
                            value_6.Transparency = 0
                        end
                    end
                end
                a1.anim.Reload.arm2_empty1_2(v66, v68)
                a1.anim.Reload.arm1_empty1(v65, v68).Completed:Wait()
                a1.states.loaded:set(true)
                a1.anim.Reload.gun_empty1(v67, v68)
                a1.anim.Reload.arm2_empty2(v66, v68).Completed:Wait()
                local v77 = a1.cframes:get(a1.feed_cover):get_offset("reload")
                a1.sound.FeedClose(a1.instance.Root)
                Util_upv_1.tween(v77, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Value = CFrame.Angles(0, 0, 0)})
                a1.anim.Reload.arm2_empty1_3(v66, v68).Completed:Wait()
            else
                a1.states.loaded:set(true)
                a1.anim.Reload.arm2_finish(v66, v68)
                a1.anim.Reload.arm1_finish(v65, v68).Completed:Wait()
            end
            if a1.states.bullets:get() <= 0 or not (a1.states.single_load:get()) then
                break
            end
            local v78 = a1.states.mag:get()
            local v79 = a1.states.mag_size:get()
            local v80 = ((a1.states.chambered:get()) and 1) or 0
            if v79 + v80 <= v78 then
                break
            else
                continue
            end
        elseif a1.states.single_load:get() then
            a1.sound.Reload2(a1.instance.Root)
            a1.single_bullet:Destroy()
            if not (a1.cylinder) then
                a1.states.loaded:set(true)
                a1.states.load_bullet:fire()
            end
            a1.anim.Reload.arm2_finish(v66, v68)
            a1.anim.Reload.arm1_finish(v65, v68).Completed:Wait()
            if a1.cylinder then
                a1.states.loaded:set(true)
                a1.states.load_bullet:fire()
            end
            if a1.cylinder then
                if n_1 == v76 then
                    if a1.loader then
                        a1.anim.Reload.arm1_start(v65, v68)
                        a1.anim.Reload.gun(v67, v68)
                        a1.anim.Reload.arm2_start(v66, v68).Completed:Wait()
                    else
                        a1.anim.Reload.gun(v67, v68)
                        if a1.anim.Reload.arm1_empty2 then
                            a1.anim.Reload.arm2_empty2(v66, v68)
                            a1.anim.Reload.arm1_empty2(v65, v68).Completed:Wait()
                        end
                        if a1.anim.Reload.arm1_empty1 then
                            a1.anim.Reload.arm2_empty1(v66, v68)
                            a1.anim.Reload.arm1_empty1(v65, v68).Completed:Wait()
                        end
                    end
                    a1.sound.Reload1(a1.instance.Root)
                    a1.anim.Reload.cylinder_close(a1.cframes:get(a1.cylinder):get_offset("reload"), v68)
                    return
                else
                    local v81 = a1.states.mag:get()
                    if a1.states.mag_size:get() <= v81 or a1.states.bullets:get() <= 0 then
                        if a1.loader then
                            a1.anim.Reload.arm1_start(v65, v68)
                            a1.anim.Reload.gun(v67, v68)
                            a1.anim.Reload.arm2_start(v66, v68).Completed:Wait()
                        else
                            a1.anim.Reload.gun(v67, v68)
                            if a1.anim.Reload.arm1_empty2 then
                                a1.anim.Reload.arm2_empty2(v66, v68)
                                a1.anim.Reload.arm1_empty2(v65, v68).Completed:Wait()
                            end
                            if a1.anim.Reload.arm1_empty1 then
                                a1.anim.Reload.arm2_empty1(v66, v68)
                                a1.anim.Reload.arm1_empty1(v65, v68).Completed:Wait()
                            end
                        end
                        a1.sound.Reload1(a1.instance.Root)
                        a1.anim.Reload.cylinder_close(a1.cframes:get(a1.cylinder):get_offset("reload"), v68)
                        return
                    else
                        if a1.states.bullets:get() <= 0 or not (a1.states.single_load:get()) then
                            break
                        end
                        local v78 = a1.states.mag:get()
                        local v79 = a1.states.mag_size:get()
                        local v80 = ((a1.states.chambered:get()) and 1) or 0
                        if v79 + v80 <= v78 then
                            break
                        else
                            continue
                        end
                    end
                end
            else
                if a1.states.bullets:get() <= 0 or not (a1.states.single_load:get()) then
                    break
                end
                local v78 = a1.states.mag:get()
                local v79 = a1.states.mag_size:get()
                local v80 = ((a1.states.chambered:get()) and 1) or 0
                if v79 + v80 <= v78 then
                    break
                else
                    continue
                end
            end
        else
            if a1.cylinder and a1.loader then
                a1.sound.Reload2(a1.instance.Root)
                a1.cframes:get(a1.loader.Case):set_pivot("reload")
                a1.anim.Reload.arm2_finish(v66, v68)
                a1.anim.Reload.arm1_finish(v65, v68).Completed:Wait()
                a1.cframes:get(a1.loader.Case):remove_pivot("reload")
                a1.loader.Bullets.Transparency = 1
                a1.states.loaded:set(true)
                a2.values.cframes:get("arm2"):set_pivot("reload")
                local v82 = a1.anim.Reload.base(v66, v68)
                v82.Completed:Connect(
                    function()
                        --[[
                          line: 1334
                          upvalues:
                            a1 (copy, index: 1)
                            a2 (copy, index: 2)
                        ]]
                        if a1.loader then
                            a1.loader.Parent = nil
                            a1.cframes:get(a1.loader.Case):remove_pivot("reload")
                        end
                        a2.values.cframes:get("arm2"):remove_pivot("reload")
                    end
                )
                if a1.anim.Reload.arm1_end1 then
                    a1.anim.Reload.gun(v67, v68)
                    a1.anim.Reload.arm1_end1(v65, v68).Completed:Wait()
                    a1.sound.Reload1(a1.instance.Root)
                    a1.anim.Reload.cylinder_close(a1.cframes:get(a1.cylinder):get_offset("reload"), v68)
                    a1.anim.Reload.arm1_end2(v65, v68).Completed:Wait()
                else
                    a1.anim.Reload.arm1_idle2(v65, v68)
                    v82.Completed:Wait()
                    a1.anim.Reload.arm1_start(v65, v68)
                    a1.anim.Reload.gun(v67, v68)
                    a1.anim.Reload.arm2_start(v66, v68).Completed:Wait()
                    a1.sound.Reload1(a1.instance.Root)
                    a1.anim.Reload.cylinder_close(a1.cframes:get(a1.cylinder):get_offset("reload"), v68)
                end
            end
            if a1.states.bullets:get() <= 0 or not (a1.states.single_load:get()) then
                break
            end
            local v78 = a1.states.mag:get()
            local v79 = a1.states.mag_size:get()
            local v80 = ((a1.states.chambered:get()) and 1) or 0
            if v79 + v80 <= v78 then
                break
            else
                continue
            end
        end
    end
end
function tbl_upv_1.reload_done(a1, a2)
    --[[
      name: reload_done
      line: 1372
    ]]
    local _ = a2.values.cframes:get("arm1"):get_absolute("reload")
    local v1 = a2.values.cframes:get("arm2"):get_absolute("reload")
    local v2 = a1.cframes:get(a1.instance.Root):get_absolute("reload")
    a1.sound.Handle(a1.instance.Root)
    a2.values.cframes:get("arm1"):remove_all_absolutes("reload")
    a2.values.cframes:get("arm2"):remove_all_absolutes("reload")
    a1.cframes:get(a1.instance.Root):remove_all_absolutes("reload")
    a1.safety:set(a2.values.holding and (a2.values.holding.loadout_type == "primary"))
end
function tbl_upv_1.reload_cancel(a1, a2)
    --[[
      name: reload_cancel
      line: 1383
      upvalues:
        Util_upv_1 (copy, index: 1)
    ]]
    if a1 == nil then
        return
    end
    local _ = a2.values.cframes:get("arm1"):get_absolute("reload")
    local v1 = a2.values.cframes:get("arm2"):get_absolute("reload")
    local v2 = a1.cframes:get(a1.instance.Root):get_absolute("reload")
    if a1.single_bullet then
        a1.single_bullet:Destroy()
        a1.single_bullet = nil
    end
    if a1.loader then
        a1.loader.Parent = nil
        a1.cframes:get(a1.loader.Case):remove_pivot("reload")
    end
    a2.values.cframes:get("arm2"):remove_pivot("reload")
    if a1.end_bullet then
        if a1.states.loaded:get() then
            a1.cframes:get(a1.end_bullet):remove_pivot("unloaded")
        else
            if a1.cframes:get(a1.end_bullet):current_pivot() ~= "unloaded" then
                a1.cframes:get(a1.end_bullet):set_pivot("unloaded")
            end
            a1.end_bullet.Transparency = 1
            for v3, value_7 in a1.end_bullet:GetChildren() do
                if value_7:IsA("BasePart") then
                    value_7.Transparency = 1
                end
            end
        end
    end
    if a1.magazine then
        a1.cframes:get(a1.magazine):remove_pivot("reload")
        if not (a1.states.loaded:get()) then
            a1:hide_mag(true)
        end
        if a1.feed_cover then
            Util_upv_1.tween(a1.cframes:get(a1.feed_cover):get_offset("reload"), TweenInfo.new(0.1), {Value = CFrame.new(0, 0, 0)})
        end
    elseif a1.cylinder then
        Util_upv_1.tween(a1.cframes:get(a1.cylinder):get_offset("reload"), TweenInfo.new(0.1), {Value = CFrame.new(0, 0, 0)})
    end
    a1.sound.Handle(a1.instance.Root)
    a2.values.cframes:get("arm1"):remove_all_absolutes("reload")
    a2.values.cframes:get("arm2"):remove_all_absolutes("reload")
    a1.cframes:get(a1.instance.Root):remove_all_absolutes("reload")
    a1.safety:set(a2.values.holding and (a2.values.holding.loadout_type == "primary"))
end
function tbl_upv_1.cock_begin(a1, a2)
    --[[
      name: cock_begin
      line: 1435
    ]]
    local v83 = not a1.states.single_load:get()
    a1.sound.Handle(a1.instance.Root)
    local v84 = a1.states.reload_speed:get()
    if a1.right_hand_hold then
        a1.cframes:get(a1.instance.Root).pivot_time = 0.1
        a1.cframes:get(a1.instance.Root):set_pivot("equipped2")
    end
    local v85 = a2.values.cframes:get("arm1"):set_absolute("cock", true)
    local v86 = a2.values.cframes:get("arm2"):set_absolute("cock", true)
    local v87 = nil
    if a1.load_slide then
        v87 = a1.cframes:get(a1.load_slide):set_offset("cock")
        a1.anim.Reload.slide_cock(v87, v84)
        if not v83 then
            a1.sound.Reload3(a1.instance.Root)
        end
    end
    a1.anim.Reload.arm1_cock(v85, v84, a1)
    a1.anim.Reload.arm2_cock(v86, v84, a1).Completed:Wait()
    if v87 then
        a1.anim.Reload.slide_cocked(v87, v84)
        local v88 = nil
        if v83 then
            a1.sound.Reload3(a1.instance.Root)
        else
            a1.sound.Reload4(a1.instance.Root)
            v88 = a1.instance:FindFirstChild("BulletEject", true)
            if v88 then
                a1:eject_bullet(v88, a1.bullet_type)
            end
        end
    else
        a1.states.chambered:set(true)
    end
    a1.anim.Reload.arm1_cocked(v85, v84, a1)
    a1.anim.Reload.arm2_cocked(v86, v84, a1).Completed:Wait()
    if not v87 then
        return
    end
    a1.states.chambered:set(true)
end
function tbl_upv_1.cock_done(a1, a2)
    --[[
      name: cock_done
      line: 1482
    ]]
    local _ = a2.values.cframes:get("arm1"):get_absolute("cock")
    local v90 = a2.values.cframes:get("arm2"):get_absolute("cock")
    local v89 = nil
    if a1.load_slide then
        v89 = a1.cframes:get(a1.load_slide):get_offset("cock")
        a1.anim.Reload.base(v89, 1)
    end
    a1.sound.Handle(a1.instance.Root)
    if v89 then
        a1.cframes:get(v89):remove_offset("cock")
    end
    a2.values.cframes:get("arm1"):remove_all_absolutes("cock")
    a2.values.cframes:get("arm2"):remove_all_absolutes("cock")
    if not a1.right_hand_hold then
        return
    end
    a1.cframes:get(a1.instance.Root):remove_pivot("equipped2")
end
function tbl_upv_1.cock_cancel(a1, a2)
    --[[
      name: cock_cancel
      line: 1501
    ]]
    if a1 == nil then
        return
    end
    local _ = a2.values.cframes:get("arm1"):get_absolute("cock")
    local v91 = a2.values.cframes:get("arm2"):get_absolute("cock")
    local v90 = nil
    if a1.load_slide then
        v90 = a1.cframes:get(a1.load_slide):get_offset("cock")
        a1.anim.Reload.base(v90, 1)
    end
    a1.sound.Handle(a1.instance.Root)
    if v90 then
        a1.cframes:get(v90):remove_offset("cock")
    end
    a2.values.cframes:get("arm1"):remove_all_absolutes("cock")
    a2.values.cframes:get("arm2"):remove_all_absolutes("cock")
    if not a1.right_hand_hold then
        return
    end
    a1.cframes:get(a1.instance.Root):remove_pivot("equipped2")
end
function tbl_upv_1.get_shoot_look(a1)
    --[[
      name: get_shoot_look
      line: 1521
      upvalues:
        FlagManager_upv_1 (copy, index: 1)
    ]]
    shared.extras.ResetEnv()
    if FlagManager_upv_1.FLAG_ADS_CAMERA_BULLETS then
        return a1.shot.CFrame:Lerp((a1.reticule or (a1.instance.Root.FrontSight)).WorldCFrame, a1.accuracy.Value)
    end
    return a1.shot.CFrame
end
function get_circular_spread(a1, a2)
    --[[
      name: get_circular_spread
      line: 1529
    ]]
    local v91 = math.random() * 2 * math.pi
    local v92 = math.random() ^ 0.35 * a2
    return (a1.RightVector * math.cos(v91) + (a1.UpVector * math.sin(v91))) * v92
end
function tbl_upv_1.send_shoot(a1)
    --[[
      name: send_shoot
      line: 1536
      upvalues:
        Util_upv_1 (copy, index: 1)
    ]]
    local owner_3 = a1.owner
    local v93 = a1:get_shoot_look()
    if a1.client_sided_hitscan then
        local v94 = a1.states.pellets:get() > 1
        local v95 = nil
        v93 = CFrame.new(Util_upv_1.validate_position(game.Workspace.CurrentCamera.CFrame.Position, v95.Position, owner_3.values.ray_params)) * v95.Rotation
        local tbl_14 = {}
        local v96 = a1.states.pellets:get()
        for n_2 = 1, v96 do
            local Position_3 = n_2.Position
            local v97 = n_2.LookVector * 1000
            local v98 = a1.states.spread:get() * 100
            local Value_2 = a1.accuracy.Value
            local v99
            if (a1.red_dot) and a1.red_dot.Transparency == 1 then
                v99 = 0.5
            else
                v99 = 1
            end
            v97 = v97 + (1 - ((Value_2 * v99) * math.map(n_2, 1, math.max(2, v96), 1, 0))) * get_circular_spread(n_2, v98)
            table.insert(tbl_14, (a1:ray_damage(Position_3, (v94 and (v97 - v97 * 0.75)) or v97, {owner_3.values.viewmodels, owner_3.instance}, nil)))
        end
        a1.states.shoot:fire_instant(v93, tbl_14)
    else
        a1.states.shoot:fire_instant(v93)
    end
end
function tbl_upv_1.send_melee(a1)
    --[[
      name: send_melee
      line: 1579
    ]]
    a1.states.melee:fire_instant()
    local CFrame_1 = a1.owner.values.camera:get().CFrame
    if a1.client_sided_hitscan then
        local owner_4 = a1.owner
        a1.states.hit:fire(CFrame_1, (a1:ray_damage(CFrame_1.Position - (CFrame_1.LookVector * 0.2), CFrame_1.LookVector * (a1.melee_range + 0.2), {owner_4.values.viewmodels, owner_4.instance}, 0.2)))
    else
        a1.states.hit:fire(CFrame_1)
    end
end
function tbl_upv_1.input_ads(a1, a2, a3)
    --[[
      name: input_ads
      line: 1598
      upvalues:
        Data_upv_1 (copy, index: 1)
        UI_upv_1 (copy, index: 2)
    ]]
    a1.ads_hold = a2
    local owner_5 = a1.owner
    if (not a2 or not owner_5.values.prone_debounce) and owner_5 and owner_5.values.equipped == a1 and not a1.meleeing then
        a1.owner.states.running:set(false)
        if Data_upv_1.settings.toggle_aim and not (a3) then
            if not a2 then
                return
            end
            a1.states.sights:update(
                function(a4)
                    --[[
                      line: 1606
                    ]]
                    return not a4
                end
            )
            local v100 = UI_upv_1.get("CancelScope")
            v100.Visible = a1.states.sights:get()
            return
        end
        a1.states.sights:set(a2)
    end
end
function tbl_upv_1.input_shoot(a1, a2, a3)
    --[[
      name: input_shoot
      line: 1617
      upvalues:
        Data_upv_1 (copy, index: 1)
        UI_upv_1 (copy, index: 2)
    ]]
    local owner_6 = a1.owner
    if owner_6 then
        if owner_6.values.equipped ~= a1 or a1.safety:get() and not (a1.accuracy.Value >= 1) or owner_6.states.running:get() then
            if Data_upv_1.settings.auto_ads and (a3 or not (UI_upv_1.get("ShootJoystickFrame").Visible)) then
                if not (a2) or a1.states.sights:get() then
                    if not (a2) and not (UI_upv_1.get("CancelScope").Visible) and not (Data_upv_1.settings.lock_auto_ads) then
                        a1:input_ads(false, true)
                    end
                else
                    a1:input_ads(true, not Data_upv_1.settings.lock_auto_ads)
                end
            end
            a1.shoot_hold = a2
            return
        end
        local v101, v102 = nil, nil
        if not (owner_6.values.equip_debounce:get()) then
            v101 = os.clock()
            v102 = a1.states.firerate:get()
            if (a1.burst_left or 0) <= 0 then
                if a2 then
                    if a3 then
                        if a1.automatic then
                            if v102 == 0 or 1 / (v102 / 60) < v101 - a1.last_shot then
                                if (a1.states.mag:get() > 0) and (a1.states.chambered:get()) then
                                    a1.last_shot = v101
                                    a1:send_shoot()
                                    if a1.burst then
                                        a1.burst_left = a1.burst - 1
                                    end
                                else
                                    a1:reload(owner_6, false)
                                end
                            end
                        elseif not (a2) and a3 and not (a1.automatic) and a1.shoot_hold and (v102 == 0 or 1 / (v102 / 60) < v101 - a1.last_shot) then
                            if (a1.states.mag:get() > 0) and (a1.states.chambered:get()) then
                                a1.last_shot = v101
                                a1:send_shoot()
                                if a1.burst then
                                    a1.burst_left = a1.burst - 1
                                end
                            else
                                a1:reload(owner_6, false)
                            end
                        end
                    elseif v102 == 0 or 1 / (v102 / 60) < v101 - a1.last_shot then
                        if (a1.states.mag:get() > 0) and (a1.states.chambered:get()) then
                            a1.last_shot = v101
                            a1:send_shoot()
                            if a1.burst then
                                a1.burst_left = a1.burst - 1
                            end
                        else
                            a1:reload(owner_6, false)
                        end
                    end
                elseif not (a2) and a3 and not (a1.automatic) and a1.shoot_hold and (v102 == 0 or 1 / (v102 / 60) < v101 - a1.last_shot) then
                    if (a1.states.mag:get() > 0) and (a1.states.chambered:get()) then
                        a1.last_shot = v101
                        a1:send_shoot()
                        if a1.burst then
                            a1.burst_left = a1.burst - 1
                        end
                    else
                        a1:reload(owner_6, false)
                    end
                end
            end
        end
    end
    if Data_upv_1.settings.auto_ads and (a3 or not (UI_upv_1.get("ShootJoystickFrame").Visible)) then
        if not (a2) or a1.states.sights:get() then
            if not (a2) and not (UI_upv_1.get("CancelScope").Visible) and not (Data_upv_1.settings.lock_auto_ads) then
                a1:input_ads(false, true)
            end
        else
            a1:input_ads(true, not Data_upv_1.settings.lock_auto_ads)
        end
    end
    a1.shoot_hold = a2
end
function tbl_upv_1.hook_inputs(a1)
    --[[
      name: hook_inputs
      line: 1644
      upvalues:
        UI_upv_1 (copy, index: 1)
        FirstPersonInterface_upv_1 (copy, index: 2)
    ]]
    local inputs_upv_1 = a1.inputs
    a1.owner.states.equipped:hook(
        function(a2)
            --[[
              line: 1647
              upvalues:
                a1 (copy, index: 1)
                inputs_upv_1 (copy, index: 2)
            ]]
            if a2 ~= a1.instance then
                inputs_upv_1:disable()
            else
                inputs_upv_1:enable()
            end
        end
    )
    a1.owner.values.equip_debounce:hook(
        function(a3)
            --[[
              line: 1655
              upvalues:
                a1 (copy, index: 1)
            ]]
            if not a3 then
                return
            end
            a1.states.sights:set(false)
        end
    )
    inputs_upv_1.enabled:hook(
        function(a4)
            --[[
              line: 1661
              upvalues:
                UI_upv_1 (copy, index: 1)
            ]]
            if not a4 then
                return
            end
            UI_upv_1.get("CancelScope").Visible = false
            UI_upv_1.get("CancelShoot").Visible = false
        end
    )
    inputs_upv_1:get("shoot"):press(
        function(a5)
            --[[
              line: 1668
              upvalues:
                UI_upv_1 (copy, index: 1)
                a1 (copy, index: 2)
            ]]
            if a5 and UI_upv_1.get("CancelShoot").Visible then
                a1.shoot_hold = false
                a1:input_shoot(false)
                UI_upv_1.get("CancelShoot").Visible = false
            else
                a1:input_shoot(a5)
            end
        end
    )
    inputs_upv_1:get("shoot_joystick"):press(
        function(a6)
            --[[
              line: 1678
              upvalues:
                a1 (copy, index: 1)
                UI_upv_1 (copy, index: 2)
            ]]
            a1:input_shoot(a6, true)
            local v103 = UI_upv_1.get("CancelShoot")
            v103.Visible = not a1.automatic and (a6)
        end
    )
    inputs_upv_1:get("aim"):press(
        function(a7)
            --[[
              line: 1683
              upvalues:
                a1 (copy, index: 1)
            ]]
            a1:input_ads(a7)
        end
    )
    inputs_upv_1:get("reload"):press(
        function(a8)
            --[[
              line: 1690
              upvalues:
                a1 (copy, index: 1)
            ]]
            local owner_7 = a1.owner
            if not a8 or not owner_7 or (a1.reload_thread.running) or (owner_7.values.equip_debounce:get()) or (owner_7.values.prone_debounce) or owner_7.values.equipped ~= a1 or owner_7.states.vault:get() ~= 0 or (owner_7.states.running:get()) then
                return
            end
            if a1.states.bullets:get() > 0 then
                local v104 = a1.states.mag:get()
                if v104 - (((a1.cylinder) and 0) or 1) < a1.states.mag_size:get() then
                    a1.states.sights:set(false)
                    a1.ads_hold = false
                    local holding_1 = owner_7.values.holding
                    if holding_1 and holding_1.can_reload == false then
                        owner_7.states.holding:set(owner_7.values.hands, true)
                        while true do
                            if owner_7.values.equip_debounce:get() then
                                owner_7.values.equip_debounce:wait()
                                continue
                            end
                            if owner_7.values.holding ~= holding_1 then
                                break
                            end
                            owner_7.values.equip_debounce:wait()
                        end
                    end
                    a1.states.reload:fire_instant()
                    if not holding_1 or holding_1.can_reload ~= false or not a1.reload_thread.running then
                        return
                    end
                    a1.reload_thread:wait()
                    task.defer(owner_7.values.requip_items)
                end
            end
        end
    )
    FirstPersonInterface_upv_1.setup_action(
        inputs_upv_1,
        function()
            --[[
              line: 1713
              upvalues:
                a1 (copy, index: 1)
            ]]
            local v105 = not a1.reload_thread.running and (not a1.cock_thread.running and ((a1.states.mag:get() < a1.states.mag_size:get() * 0.2) and (a1.states.bullets:get() > 0)))
            return v105
        end,
        "Reload",
        "reload"
    )
end
function tbl_upv_1.update_ui(a1)
    --[[
      name: update_ui
      line: 1725
    ]]
    local v106 = a1.states.bullets:get()
    local v107 = ("%*/%*"):format(a1.states.mag:get(), ((v106 >= 1000) and "\226\136\158") or v106)
    for _, value_8 in a1.hooked_labels do
        value_8.Text = v107
    end
end
function tbl_upv_1.load()
    --[[
      name: load
      line: 1736
      upvalues:
        StateObject_upv_1 (copy, index: 1)
        tbl_upv_1 (copy, index: 2)
        State_upv_1 (copy, index: 3)
        Event_upv_1 (copy, index: 4)
        Globals_upv_1 (copy, index: 5)
    ]]
    StateObject_upv_1.class(
        tbl_upv_1.tag,
        function()
            --[[
              line: 1737
              upvalues:
                State_upv_1 (copy, index: 1)
                Event_upv_1 (copy, index: 2)
                Globals_upv_1 (copy, index: 3)
            ]]
            local tbl_15 = {}
            tbl_15.loaded = State_upv_1.new(true)
            tbl_15.mag_size = State_upv_1.new(0)
            tbl_15.bullets = State_upv_1.new(0)
            tbl_15.speed = State_upv_1.new(1)
            tbl_15.sights = State_upv_1.new(false)
            tbl_15.reload = Event_upv_1.new()
            tbl_15.cock = Event_upv_1.new()
            tbl_15.melee = Event_upv_1.new()
            tbl_15.firerate = State_upv_1.new(0)
            tbl_15.ads = State_upv_1.new(0)
            tbl_15.reload_speed = State_upv_1.new(1)
            tbl_15.recoil_up = State_upv_1.new(1)
            tbl_15.recoil_side = State_upv_1.new(0)
            tbl_15.trail_size = State_upv_1.new(0)
            tbl_15.single_load = State_upv_1.new(false)
            tbl_15.zoom = State_upv_1.new(1)
            tbl_15.load_bullet = Event_upv_1.new()
            tbl_15.shoot = Event_upv_1.new()
            tbl_15.hit = Event_upv_1.new()
            tbl_15.spread = State_upv_1.new(1)
            tbl_15.pellets = State_upv_1.new(1)
            tbl_15.accuracy = State_upv_1.new(1)
            tbl_15.mag = State_upv_1.new(0)
            tbl_15.chambered = State_upv_1.new(true)
            for _, value_9 in Globals_upv_1.attachment_types do
                tbl_15[value_9 .. "_att"] = State_upv_1.new("")
            end
            return tbl_15, {}
        end
    ):hook(function(a1)
        --[[
          line: 1776
        ]]
    end)
end
return tbl_upv_1
