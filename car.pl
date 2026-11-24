:- dynamic yes_symptom/1.

% Rule 1: Dead Battery
fault(dead_battery) :-
    yes_symptom(engine_not_starting),
    yes_symptom(clicking_sound),
    yes_symptom(dim_lights).

% Rule 2: Out of Fuel
fault(out_of_fuel) :-
    yes_symptom(engine_not_starting),
    yes_symptom(fuel_gauge_empty).

% Rule 3: Overheating Engine
fault(overheating_engine) :-
    yes_symptom(high_temperature),
    yes_symptom(steam_from_hood),
    yes_symptom(coolant_low).

% Rule 4: Worn Brake Pads
fault(worn_brake_pads) :-
    yes_symptom(squealing_brakes),
    yes_symptom(long_braking_distance).

% Rule 5: Flat Tire
fault(flat_tire) :-
    yes_symptom(pulling_to_one_side),
    yes_symptom(tire_pressure_warning).

% Rule 6: Faulty Spark Plugs
fault(faulty_spark_plugs) :-
    yes_symptom(rough_idle),
    yes_symptom(poor_acceleration).

% Ask the user about every symptom exactly once
ask_symptoms :-
    ask(engine_not_starting),
    ask(clicking_sound),
    ask(dim_lights),
    ask(fuel_gauge_empty),
    ask(high_temperature),
    ask(steam_from_hood),
    ask(coolant_low),
    ask(squealing_brakes),
    ask(long_braking_distance),
    ask(pulling_to_one_side),
    ask(tire_pressure_warning),
    ask(rough_idle),
    ask(poor_acceleration).

% Ask the user about one symptom
ask(Symptom) :-
    write('Does the car have '),
    write(Symptom),
    write('? (yes/no): '),
    read(Answer),
    (
        Answer == yes
    ->
        assertz(yes_symptom(Symptom))
    ;
        true
    ).

start :-
    % Clear previous symptoms
    retractall(yes_symptom(_)),
    nl,
    write('===================================='), nl,
    write('   CAR FAULT DIAGNOSIS EXPERT SYSTEM'), nl,
    write('===================================='), nl,
    nl,
    % Ask all questions
    ask_symptoms,
    nl,
    write('========== DIAGNOSIS =========='), nl,
    % Find faults using backtracking
    show_faults.

show_faults :-
    fault(Fault),
    write('Possible Fault: '),
    write(Fault),
    nl,
    fail.
show_faults :-
    nl,
    write('========== END =========='), nl.
