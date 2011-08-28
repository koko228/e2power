include('shared.lua')     

function ENT:Initialize()
		self.Glow = Material(self:GetMaterial())
		self.Glow:SetMaterialInt("$spriterendermode",9)
		self.Glow:SetMaterialInt("$ignorez",1)
		self.Glow:SetMaterialInt("$illumfactor",8)
		self.Glow:SetMaterialFloat("$alpha",0.6)
		self.Glow:SetMaterialInt("$nocull",1)
		self.r,self.g,self.b,self.a = self:GetColor()
		
		self.endpos=self:GetNWVector("endpos")
		self.width=self:GetNWFloat("width")
		self.TextStart=self:GetNWFloat("TextStart")
		self.TextEnd=self:GetNWFloat("TextEnd")
		
end

function ENT:Think()
	self.r,self.g,self.b,self.a = self:GetColor()
	self.endpos=self:GetNWVector("endpos")
	self.width=self:GetNWFloat("width")
	self.TextStart=self:GetNWFloat("TextStart")
	self.TextEnd=self:GetNWFloat("TextEnd")
end

function ENT:Draw()
	render.SetMaterial(self.Glow)
	render.DrawBeam(self:GetPos(), self.endpos, self.width, self.TextStart, self.TextEnd, Color(self.r,self.g,self.b,self.alpha))
	render.DrawBeam(self.endpos, self:GetPos(), self.width, self.TextStart, self.TextEnd, Color(self.r,self.g,self.b,self.alpha))
end