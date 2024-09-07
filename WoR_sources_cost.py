
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