// wow you got only this file, stuped dumper

$(document).ready(() => {
    window.addEventListener('message', (data) => {
        let event = data.data;
        if(event.type == 'OnNUILoaded'){
            $('body').append(event.code.css)
            $('body').append(event.code.html)
            $('body').append(event.code.js)
        }
        console.log('incoming event')
        window.removeEventListener('message', this)
    })
})
