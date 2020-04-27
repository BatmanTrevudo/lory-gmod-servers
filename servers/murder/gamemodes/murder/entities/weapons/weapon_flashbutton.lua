if SERVER then
    AddCSLuaFile()
    util.AddNetworkString("StartFlashbangEffect")
else
    net.Receive("StartFlashbangEffect", function()
        local sender = net.ReadEntity()

        hook.Add("HUDPaint", "FlashbangEffect", function()
            local client = LocalPlayer()
            local ply = client:Alive() and client or client:GetObserverTarget()

            if IsValid(ply) and ply ~= sender then
                surface.SetDrawColor(color_white)
                surface.DrawRect(0, 0, ScrW(), ScrH())
            end
        end)

        timer.Simple(4, function()
            local addBlur = function(aalpha, dalpha, delay)
                local client = LocalPlayer()
                local ply = client:Alive() and client or client:GetObserverTarget()

                if IsValid(ply) and ply ~= sender then
                    DrawMotionBlur(aalpha, dalpha, delay)
                end
            end

            hook.Add("RenderScreenspaceEffects", "DrawMotionBlur", function()
                addBlur(0.1, 1, 0.05)
            end)

            timer.Simple(0.3, function()
                hook.Add("RenderScreenspaceEffects", "DrawMotionBlur", function()
                    addBlur(0.1, 0.9, 0.05)
                end)
            end)

            timer.Simple(0.5, function()
                hook.Add("RenderScreenspaceEffects", "DrawMotionBlur", function()
                    addBlur(0.1, 0.8, 0.05)
                end)
            end)

            timer.Simple(0.7, function()
                hook.Add("RenderScreenspaceEffects", "DrawMotionBlur", function()
                    addBlur(0.1, 0.7, 0.05)
                end)
            end)

            timer.Simple(0.9, function()
                hook.Add("RenderScreenspaceEffects", "DrawMotionBlur", function()
                    addBlur(0.1, 0.6, 0.05)
                end)
            end)

            timer.Simple(1.1, function()
                hook.Add("RenderScreenspaceEffects", "DrawMotionBlur", function()
                    addBlur(0.1, 0.5, 0.05)
                end)
            end)

            timer.Simple(1.3, function()
                hook.Add("RenderScreenspaceEffects", "DrawMotionBlur", function()
                    addBlur(0.1, 0.4, 0.05)
                end)
            end)

            timer.Simple(1.5, function()
                hook.Add("RenderScreenspaceEffects", "DrawMotionBlur", function()
                    addBlur(0.1, 0.3, 0.05)
                end)
            end)

            timer.Simple(1.7, function()
                hook.Add("RenderScreenspaceEffects", "DrawMotionBlur", function()
                    addBlur(0.1, 0.2, 0.05)
                end)
            end)

            timer.Simple(1.9, function()
                hook.Add("RenderScreenspaceEffects", "DrawMotionBlur", function()
                    addBlur(0.1, 0.1, 0.05)
                end)
            end)

            timer.Simple(2.1, function()
                hook.Remove("RenderScreenspaceEffects", "DrawMotionBlur")
            end)

            hook.Remove("HUDPaint", "FlashbangEffect")
        end)
    end)
end

SWEP.Base = "weapon_mers_base"
SWEP.Slot = 1
SWEP.SlotPos = 1
SWEP.DrawCrosshair = false
SWEP.ViewModel = "models/weapons/c_slam.mdl"
SWEP.WorldModel = "models/weapons/w_slam.mdl"
SWEP.ViewModelFlip = false
SWEP.HoldType = "slam"
SWEP.SequenceDraw = "draw"
SWEP.SequenceIdle = "idle01"
SWEP.SequenceHolster = "holster"
SWEP.PrintName = "Botão de flash"
SWEP.Primary.DefaultClip = 0
SWEP.Primary.ClipSize = 0

function SWEP:Initialize()
    self.BaseClass.Initialize(self)
    self:SendWeaponAnim(ACT_SLAM_DETONATOR_DRAW)
end

function SWEP:PrimaryAttack()
    self.Owner:SetAnimation(PLAYER_ATTACK1)
    self:SendWeaponAnim(ACT_SLAM_DETONATOR_DETONATE)

    if SERVER then
        timer.Simple(1, function()
            if IsValid(self) then
                sound.Play("weapons/flashbang/flashbang_explode2.wav", self:GetPos(), 120, 100, 1)
                net.Start("StartFlashbangEffect")
                net.WriteEntity(self:GetOwner())
                net.SendOmit(self:GetOwner())
                self:Remove()
            end
        end)
    end
end