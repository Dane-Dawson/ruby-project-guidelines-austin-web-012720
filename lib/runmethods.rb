def title_logo
    puts PASTEL.red(FONT.write("vvvvvvv", letter_spacing: 2))
    puts PASTEL.bright_red(FONT.write("|||>RUBY<||", letter_spacing: 2))
    puts PASTEL.bright_red(FONT.write("|>WIZARD<|", letter_spacing: 2))
    puts PASTEL.red(FONT.write("^^^^^^^^^^^^", letter_spacing: 2))
end

def game_intro
    PROMPT.say("Welcome to ", color: :green) 
    PROMPT.say("RUBY WIZARD ", color: :bright_red)
    PROMPT.say("!", color: :green) 
    PROMPT.yes?('Is this your first time playing?', help_color: :green, active_color: :green)
    PROMPT.say("Who cares! We don't have enough content for that to matter right now!", color: :green)
    puts " "
    puts " "
    PROMPT.say("Ruby wizard will be an educational text-based game focused on Ruby as a programming language", color: :bright_red)
    PROMPT.say("Please enjoy what will hopefully be a pleasant experience, and apologies if you break the code...", color: :bright_red)
    puts ""
    PROMPT.say(". . . . . . . . . .", color: :red)
    PROMPT.say(". . . . . . . . . .", color: :red)
    puts ""
    PROMPT.say(". . . . . . . . . .", color: :red)
    puts ""
    PROMPT.say(". . . . . . . . . .", color: :red)
    PROMPT.say(". . . . . . . . . .", color: :red)
    puts ""
    PROMPT.say("...but you probably deserve it.", color: :bright_red)
    puts ""
    puts ""
    PROMPT.yes?('Are you ready to start?', help_color: :green, active_color: :green)
    puts ""
    puts ""
    PROMPT.say("Doesn't matter, let's go!", color: :bright_red)
    puts ""
    puts ""
    puts ""

end

def end_screen
    PROMPT.say("As you stumble through the clearing ahead, you notice...nothing. Absolutely nothing for you to fight or do.", color: :bright_red)
    PROMPT.ask("Did...did you win?")
    PROMPT.say("You did!!", color: :bright_red)
    PROMPT.ask("Press enter to win!")
    puts PASTEL.red(FONT.write(". . . . . . . . . . .", letter_spacing: 3))
    puts PASTEL.bright_red(FONT.write(" YOU   HAVE", letter_spacing: 2))
    puts PASTEL.bright_red(FONT.write("CONQUERED", letter_spacing: 2))
    puts PASTEL.bright_red(FONT.write("THIS ALPHA", letter_spacing: 2))
    puts PASTEL.red(FONT.write("^^^^^^^^^^^^^^", letter_spacing: 2))
end

def spell_prompt
    spell = PROMPT.select("Pick which spell to cast", %w(Manabolt Inspect Frostbolt), active_color: :bright_red, per_page: 6)
    PROMPT.say("You cast #{spell}!", color: :blue)
    spell
end

def cast_spell(spell_name, challenge_id)
    spell = Spell.find_by(name: spell_name)
    target = Challenge.find_by(id: challenge_id)
    # will modify based on attributes later
    target.receive_spell(spell)
end

def combat(challenge_id)
    encounter_challenge = Challenge.find_by(id: challenge_id)
    location = Location.find_by(id: challenge_id)
    puts ""
    puts ""
    puts ""
    if encounter_challenge.health > 0 
        PROMPT.say("choose your spell wisely", color: :green)
        spell_name = spell_prompt
        cast_spell(spell_name, challenge_id)
    end

end

def enter_location(challenge_id)
    encounter_challenge = Challenge.find_by(id: challenge_id)
    location = Location.find_by(id: challenge_id)
    PROMPT.say("You have entered #{location.name}. #{location.description}", color: :bright_red)
    PROMPT.say("Checking to see if there are enemies nearby...", color: :green)
    #encounter_challenges.each do |challenge|
        if !encounter_challenge.stealth
            PROMPT.say("You spotted one!", color: :red)
            PROMPT.say("~~~~~~~~~~~~~~~~~", color: :green)
            PROMPT.say("~~~~~~~~~~~~~~~~~", color: :green)
            PROMPT.say("You see a #{encounter_challenge.name}. #{encounter_challenge.description}", color: :bright_red)
        end
    #end
end

def initialize_and_complete_combat(player)
    enter_location(player.current_encounter)
    combat(player.current_encounter)
end

def reset_database
    Challenge.delete_all
    Encounter.delete_all
    Location.delete_all
    Spell.delete_all
    Spellbot.delete_all
end

def game_startup
    #title_logo
    #game_intro
    #reset_database
    name = PROMPT.ask("What is your name?")
    player = Spellbot.create(name: name, current_encounter: 1)
    initialize_and_complete_combat(player)
    #end_screen
end

