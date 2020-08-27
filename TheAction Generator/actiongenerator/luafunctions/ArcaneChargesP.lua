function Player:ArcaneChargesP()
    return math.min(self:ArcaneCharges() + num(self:IsCasting(A.ArcaneBlast)),4)
end