library(here)

instances_dir <- 'benchmarks/instances'

getScenarioInfo <- function(){
    scenario_read <- here("sources", "read_scenarios.r")
    source(scenario_read)

    instances <- getScenariosInstances()
    print(instances)
}

main <- function(){
    getScenarioInfo()
}

main()

