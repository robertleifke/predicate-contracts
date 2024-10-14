#!/bin/bash

binding_dir="./../gen/bindings"

function create_binding {
    contract=$1
    with_interfaces=$2
    echo "Generating bindings for" $contract

    # Assuming your compiled contract JSON is in the out directory
    contract_json="./out/${contract}.sol/${contract}.json"
    solc_abi=$(cat ${contract_json} | jq -r '.abi')
    solc_bin=$(cat ${contract_json} | jq -r '.bytecode.object')

    mkdir -p data
    echo ${solc_abi} >data/tmp.abi
    echo ${solc_bin} >data/tmp.bin

    rm -f $binding_dir/${contract}/binding.go
    if [ "$with_interfaces" == "true" ]; then
        docker run -v $(realpath $binding_dir):/home/binding_dir -v .:/home/repo abigen-with-interfaces --bin=/home/repo/data/tmp.bin --abi=/home/repo/data/tmp.abi --pkg=${contract} --out=/home/binding_dir/${contract}/binding.go
    else
        mkdir -p $binding_dir/${contract}
        abigen --bin=data/tmp.bin --abi=data/tmp.abi --pkg=${contract} --out=$binding_dir/${contract}/binding.go
    fi
    rm -rf data/tmp.abi data/tmp.bin
    rm -f tmp.abi tmp.bin
}

# Clean and build the contracts
forge clean
forge build

# Generate bindings for your contract

create_binding "ServiceManager" true
create_binding "MockClient" true
create_binding "IAVSDirectory" true
create_binding "PredicateClient" true
create_binding "DummyToken" true
create_binding "MetaCoin" false