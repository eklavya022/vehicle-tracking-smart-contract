module MyModule::VehicleTracking {
    use aptos_framework::signer;

    /// Struct representing a vehicle.
    struct Vehicle has store, key {
        owner: address,  // Current owner of the vehicle
        vin: vector<u8>, // Vehicle Identification Number (VIN)
    }

    /// Function to register a new vehicle.
    public fun register_vehicle(owner: &signer, vin: vector<u8>) {
        let vehicle = Vehicle {
            owner: signer::address_of(owner),
            vin,
        };
        move_to(owner, vehicle);
    }

    /// Function to transfer ownership of a vehicle.
    public fun transfer_ownership(new_owner: address, old_owner: &signer) acquires Vehicle {
        let vehicle = borrow_global_mut<Vehicle>(signer::address_of(old_owner));
        vehicle.owner = new_owner;
    }
}
