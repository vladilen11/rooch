module argument_resolver::argument_resolver {
    use moveos_std::object;
    use moveos_std::object::{Object, ObjectID};
    use std::vector;
    use std::signer;
    use std::debug;
    use std::string::String;

    struct MockObject has key,store,drop,copy {value: u64}

    entry public fun create_mock_object_to_sender(account: &signer, arg: u64) {
        let user_object = object::new(MockObject{value: arg});
        let object_id = object::id(&user_object);
        debug::print(&object_id);
        object::transfer(user_object, signer::address_of(account));
    }

    entry public fun object(_account:&signer, object: Object<MockObject>, arg: u64) {
        assert!(object::borrow(&object).value == arg, 1);
        object::remove(object);
    }

    entry public fun object_ref(_account: &signer, object_ref: &Object<MockObject>, arg: u64) {
        assert!(object::borrow(object_ref).value == arg, 1);
    }

    entry public fun object_mut_ref(_account: &signer, mut_object_ref: &mut Object<MockObject>, arg: u64) {
        assert!(object::borrow_mut(mut_object_ref).value == arg, 1);
    }

    public fun vector_string_argument(_account: &signer, string_vector_argument: vector<String>): String {
        vector::pop_back(&mut string_vector_argument)
    }

    public fun vector_object_id_argument(_account: &signer, object_id_vector_argument: vector<ObjectID>): ObjectID {
        vector::pop_back(&mut object_id_vector_argument)
    }

    public fun string_argument(_account: &signer, string_argument: String): String {
        string_argument
    }

    public fun object_id_argument(_account: &signer, object_id_argument: ObjectID): ObjectID {
        object_id_argument
    }
}