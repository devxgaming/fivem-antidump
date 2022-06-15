// wow you got only this file, stuped dumper

$(document).ready(() => {
    window.addEventListener('message', (data) => {
        let event = data.data;
        if(event.type == 'OnNUILoaded'){
            $('.root').html(event.code)
        }
    })
})