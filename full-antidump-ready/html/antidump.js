// wow you got only this file, stuped dumper

$(document).ready(() => {
    window.addEventListener('message', (data) => {
        let event = data.data;
        if(event.type == 'OnNUILoaded'){
            if(event.code.css != undefined){
                $('body').append(event.code.css)
            }
            if(event.code.html != undefined){
                $('body').append(event.code.html)
            }
            
            if(event.code.js != undefined){
                $('body').append(event.code.js)
            }
        }
        console.log('incoming event')
        window.removeEventListener('message', this)
    })
})
