function fetchUser(id){
    $.ajax({
        url:         "http://localhost:3000/users/" + id + ".js",
        dataType:    "jsonp",
        type:        "GET",
        processData: false,
        contentType: "application/json",
        success: function(data){
            console.log(data);
        }
    });
};

function fetchUsers(){
    fetchUser(1);
};
