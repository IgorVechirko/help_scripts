

posible_items_rarity = {
    "gear": ("rare", "epic", "legend", "mythic", "ancient_legend", "ancient_mythic"),
    "artifact": ("epic", "legend", "mythic", "gleming"),
    "gold": None,
    "exp": None,
    "hero": ("common", "magic", "rare", "epic", "legend"),
    "mythril": None,
    "extract": ("legend", "mythic"),
    "insignia_marksman": ("I", "II", "III"),
    "insignia_mage": ("I", "II", "III"),
    "insignia_endurance": ("I", "II", "III"),
    "insignia_fight": ("I", "II", "III")
}

class Item:
    def __init__(self, item_type, rarity = None):
        if item_type not in list(posible_items_rarity) or ((not isinstance(rarity, None)) and (rarity not in posible_items_rarity[item_type])):
            Exception(f"No sush item: {item_type} {rarity}")

exp_raid_drop = (16, {Item("hero", "rare"): 1, Item("hero", "magic"): 11, Item("hero", "common"): 7, Item("gold"): 12000})
exp_raid_drop = (41, {Item("hero", "rare"): 1, Item("hero", "magic"): 23, Item("hero", "common"): 22, Item("gold"): 37750})
exp_raid_drop = (29, {Item("hero", "rare"): 1, Item("hero", "magic"): 21, Item("hero", "common"): 15, Item("gold"): 21750})

gold_raid_drop = (8, {Item("hero", "magic"): 4, Item("hero", "common"): 5, Item("gold", None, "x2"): 504800, Item("exp"): 19630})
gold_raid_drop = (8, {Item("hero", "magic"): 6, Item("hero", "common"): 4, Item("gold", None, "x2"): 508800, Item("exp"): 19630})
gold_raid_drop = (12, {Item("hero", "magic"): 10, Item("hero", "common"): 9, Item("gold", None, "x2"): 763200, Item("exp"): 29440})
gold_raid_drop = (39, {Item("hero", "magic"): 27, Item("hero", "common"): 22, Item("gold", None, "x2"): 2480000, Item("exp"): 95700})
gold_raid_drop = (23, {Item("hero", "magic"): 13, Item("hero", "common"): 12, Item("gold", None, "x2"): 1462000, Item("exp"): 56440})

marksmen_insignia_15 = (10, {Item("gold", None, "x2"): 7800, Item("exp"): 136500, Item("insignia_marksman", "III): 74})
marksmen_insignia_15 = (6, {Item("gold", None, "x2"): 9360, Item("exp"): 8190, Item("insignia_marksman", "III): 78, Item("extract", "mythic"): 1})
marksmen_insignia_15 = (43, {Item("goldЄ): 37760, Item("exp"): 57330, Item("insignia_marksman", "III): 291, Item("extract", "mythic"): 2, Item("extract", "legend"): 2})
                                                                                                       

class Raid:
    def __init__(self, name, stamina):
        self._name = name
        self._stamina = stamina
        self._visit_times = 0
        self._items_droped = {}

    def add_stat(tries, drops):
        self._vist_times += tries

        for item, amount in drops:
            if item in list(self._items_droped):
                self._items_droped[item] += amount
            else:
                self._items_droped[item] = amount

    def calc_avg_outcome(tries):
        pass

class BraveConquest:
    def __init__(self):
        self._raids = {}
        self._raids["gear_raid"] = {}
        self._raids["gear_raid"]["rare"] = 3
        self._raids["gear_raid"]["epic"] = 7
        self._raids["gear_raid"]["legend"] = 15
        self._raids["gear_raid"]["mythic"] = 20
        self._raids["gear_raid"]["ancient_legend"] = 20
        self._raids["gear_raid"]["ancient_mythic"] = 20
        self._raids["gear_raid_I"] = self._raids["gear_raid"]
        self._raids["gear_raid_II"] = self._raids["gear_raid"]
        self._raids["gear_raid_III"] = self._raids["gear_raid"]
        
        self._raids["artifact_raid"] = {}
        self._raids["artifact_raid"]["epic"] = 2
        self._raids["artifact_raid"]["legend"] = 4
        self._raids["artifact_raid"]["mythic"] = 6

    def get_poits_by_vist_raid_n_times(raid, n = 1):
        if raid.name() not in list(self._raids):
            raise Exception(f"No {raid.name()} raid in list")
        
        raid_avg_drop = raid.current_avg_drop();


gold_raid_stamina = 26
gold_from_gold_raid = 31800
gold_from_gold_raid_with_boost = 2 * gold_from_gold_raid

gold_in_stamina = gold_from_gold_raid_with_boost / gold_raid_stamina
stamina_in_gold = (gold_raid_stamina / gold_from_gold_raid_with_boost)


exp_raid_stamina = 36
doc_exp_from_exp_raid = 10500
actual_exp_from_exp_raid = 13750
exp_from_exp_raid_with_boost = 2 * actual_exp_from_exp_raid

exp_in_stamina = exp_from_exp_raid_with_boost / exp_raid_stamina
stamina_in_exp = (exp_raid_stamina / exp_from_exp_raid_with_boost)


print(f"Gold in stamina {gold_in_stamina}. Stamina in gold {stamina_in_gold}")
print(f"Exp in stamina {exp_in_stamina}. Stamina in exp {stamina_in_exp}")


legendary_extract_get_tries = 6
legendary_extract_try_cost = 18

legendary_extract_gold_cost = (legendary_extract_get_tries * legendary_extract_try_cost) * gold_in_stamina

print(f"Leg extr gold {legendary_extract_gold_cost} ")

class HeroTraining:
    def __init__(self):
        self._raise_level = {}
        
        for i in range(2,21):
            map[i] = 1

        for i in range(21,31):
            map[i] = 2

        for i in range(31,41):
            map[i] = 3

        for i in range(41,51):
            map[i] = 6

        for i in range(41,51):
            map[i] = 8


        self._start_up = {}
        self._start_up[2] = 5
        self._start_up[3] = 15
        self._start_up[4] = 50
        self._start_up[5] = 100
        self._start_up[6] = 300

        self._promote = {}
        self._promote['epic'] = {1:2, 2:6, 3:11, 4:16, 5:36, 6:80}
        self._promote['legend'] = {1:3, 2:10, 3:15, 4:25, 5:60, 6:135}

        self._skill_up = {}
        self._skill_up["epic"] = {1:1,
                                  2:1,
                                  3:3,
                                  4:5,
                                  5:60,
                                  6:60,
                                  7:65,
                                  8:65,
                                  9:65,
                                  10:70}
        self._skill_up["legend"] = {1:2,
                                    2:2,
                                    3:5,
                                    4:5,
                                    5:7,
                                    6:10,
                                    7:140,
                                    8:145,
                                    9:150,
                                    10:150,
                                    11:155,
                                    12:155,
                                    13:155,
                                    14:160,
                                    15:160,
                                    16:170}

    def raise_hero(from_lvl, to_lvl) -> int:
        True
    def start_up_hero(to_star) -> int:
        True


print(17*14 + (17+71)*25 + (23+14)*80 + (8+17)*130 + 160 + 170 + 140 + 145 + 150 + 150 + 75 + 125*6 + 60 + 320 + 63 + 6193)




















