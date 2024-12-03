classdef Player
    properties
        HP % hit points
        % AC % armor, 7 if ShieldTimer > 0
        Mana % if Player cannot afford to cast a spell, they lose
        ShieldTimer % starts at 6 when cast, decreases by 1 after applying
        PoisonTimer % starts at 6 when cast, decreases by 1 after applying
        RechargeTimer % starts at 5 when cast, decreases by 1 after applying
        ManaSpent % starts at 0, increases when a spell is cast
        BossHP
        BossDmg
    end

    methods
        function obj = Player(HP,Mana,BossHP,BossDmg)
            obj.HP = HP;
            obj.Mana = Mana;
            obj.ShieldTimer = 0;
            obj.PoisonTimer = 0;
            obj.RechargeTimer = 0;
            obj.ManaSpent = 0;
            obj.BossHP = BossHP;
            obj.BossDmg = BossDmg;
        end

        function self = PlayerTurn(self,spell,hard)
            % disp(['player turn, casting: ',num2str(spell)])
            if hard
                self.HP = self.HP - 1;
                if self.HP <= 0
                    % disp('player died from being too hard :(')
                    return
                end
            end
            self.BossHP = self.BossHP - 3*(self.PoisonTimer>0);
            if self.BossHP <= 0
                % disp('boss died from poison')
                return
            end
            self.Mana = self.Mana + 101*(self.RechargeTimer>0);
            self.ShieldTimer = max(self.ShieldTimer-1,0);
            self.PoisonTimer = max(self.PoisonTimer-1,0);
            self.RechargeTimer = max(self.RechargeTimer-1,0);
            costs = [53 73 113 173 229];
            if self.Mana < costs(spell)
                self.HP = 0; % player fucking DIES
                % disp('player died from lack of mana :(')
                return
            end
            self = SpendMana(self,costs(spell));
            switch spell
                case 1 %'magicmissile'
                    self.BossHP = self.BossHP - 4;
                    if self.BossHP <= 0
                        % disp('boss died from MM')
                        return
                    end
                case 2 %'drain'
                    self.BossHP = self.BossHP - 2;
                    self.HP = self.HP + 2;
                    if self.BossHP <= 0
                        % disp('boss died from drain')
                        return
                    end
                case 3 %'shield'
                    if self.ShieldTimer > 0
                        self.HP = 0;
                    end
                    self.ShieldTimer = 6;
                case 4 %'poison'
                    if self.PoisonTimer > 0
                        self.HP = 0;
                    end
                    self.PoisonTimer = 6;
                case 5 %'recharge'
                    if self.RechargeTimer > 0
                        self.HP = 0;
                    end
                    self.RechargeTimer = 5;
            end
        end

        function self = BossTurn(self)
            % disp('boss turn')
            self.BossHP = self.BossHP - 3*(self.PoisonTimer>0);
            if self.BossHP <= 0
                % disp('boss died from poison')
                return
            end
            self.HP = self.HP - (self.BossDmg - 7*(self.ShieldTimer>0));
            if self.HP <= 0
                % disp('player died from boss :(')
                return
            end
            self.Mana = self.Mana + 101*(self.RechargeTimer>0);
            self.ShieldTimer = max(self.ShieldTimer-1,0);
            self.PoisonTimer = max(self.PoisonTimer-1,0);
            self.RechargeTimer = max(self.RechargeTimer-1,0);
        end
        
        function self = SpendMana(self,mana)
            self.Mana = self.Mana - mana;
            self.ManaSpent = self.ManaSpent + mana;
        end
    end
end