include('shared.lua')     

function ENT:Initialize()
		self.Glow = Material(self:GetMaterial()) --Material("sprites/light_glow02")
		self.Glow:SetMaterialInt("$spriterendermode",9)
		self.Glow:SetMaterialInt("$ignorez",1)
		self.Glow:SetMaterialInt("$illumfactor",8)
		self.Glow:SetMaterialFloat("$alpha",0.6)
		self.Glow:SetMaterialInt("$nocull",1)
		self.x=self:GetNWFloat("x")
		self.y=self:GetNWFloat("y")
end

function ENT:Draw()
	render.SetMaterial(self.Glow)
	self.r,self.g,self.b,self.a = self:GetColor()
	render.DrawSprite(self:GetPos(),self.x,self.y,Color(self.r,self.g,self.b,self.a))
end

