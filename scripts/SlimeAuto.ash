//Slimetube Auto v0.1 by iloath

script "SlimeAuto.ash"; 
notify iloath;

//need outfit named SlimeML: maximize ML and slime res here
//need a outfit named SlimeNegML: minimize ML here
//you can set the number in the following line depending on your resistance/combat ability
//"if (have_effect($effect[Coated in Slime]) =="


int adv1_slimetube()
{
	//return 1 if combat
	//return 2 if nc
	//return 10 if boss
	if (my_adventures() == 0) abort("No adventures.");
	if (get_counters("Fortune Cookie",0,0) != "") {
		abort("Semirare! LastLoc: " + get_property("semirareLocation"));
	}
	if (have_effect($effect[Beaten Up]) > 0)
	{
		chat_clan("BEATEN UP","slimetube");
		abort("Beaten up");
	}
	//you can use as low as 4 turns depending on stats
	if (have_effect($effect[Coated in Slime]) == 6)
	{
		chat_clan("HEAVY SLIME","slimetube");
		//abort("Heavy Slime");
		visit_url("clan_slimetube.php?action=bucket");
		visit_url("clan_slimetube.php?action=chamois");
	}
	if (have_effect($effect[Coated in Slime]) == 0)
	{
		outfit( "SlimeNL" );
		chat_clan("EASY SLIME","slimetube");
		restore_hp(my_maxhp());
		restore_mp(200);
		string page = visit_url("adventure.php?snarfblat=203");
		if (page.contains_text("You're fighting")) {
			run_combat();
			outfit( "SlimeML" );
			return 1;
		}
		else if (page.contains_text("Engulfed!")) {
			run_choice(2);
			chat_clan("SQUEEZE","slimetube");
			return 2;
		}
		else if (page.contains_text("Showdown")) {
			chat_clan("SLIME BOSS","slimetube");
			abort("SLIME BOSS");
			return 10;
		}
	}
	else
	{
		restore_hp(my_maxhp());
		restore_mp(200);
		string page = visit_url("adventure.php?snarfblat=203");
		if (page.contains_text("You're fighting")) {
			run_combat();
			return 1;
		}
		else if (page.contains_text("More Like... Hurtle")) {
			run_choice(1);
			chat_clan("TURTLE TAMED","hobopolis");
			return 0;
		}
		else if (page.contains_text("Engulfed!")) {
			run_choice(2);
			chat_clan("SQUEEZE","slimetube");
			return 2;
		}
		else if (page.contains_text("Showdown")) {
			chat_clan("SLIME BOSS","slimetube");
			abort("SLIME BOSS");
			return 10;
		}
	}
	return -1;
}

void main(){
	
	while (adv1_slimetube() < 10) {
		//do nothing
	}
	
}
