function doLike(pid, uid, element) {
    // Access the card's elements using 'element' and 'pid'
    const likeStatus = false;
    const d = {
        uid: uid,
        pid: pid,
        operation: 'like'
    };
    const card = $(element).closest('.card'); // Find the parent card element

    $.ajax({
        url: "LikeServlet",
        data: d,
        success: function (data, textStatus, jqXHR) {
            console.log(data);
            const likeCounter = card.find('.like-counter'); // Find the like counter within the card

            if (data.trim() === 'true') {
                let c = parseInt(likeCounter.html()) + 1; // Increment the counter
                console.log(c);
                likeCounter.html(c);
                card.find("#up_" + pid).hide();
                card.find("#down_" + pid).show();
            } else {
                let c = parseInt(likeCounter.html()) - 1; // Decrement the counter
                likeCounter.html(c);
                card.find("#up_" + pid).show();
                card.find("#down_" + pid).hide();
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(data);
        }
    });
}
