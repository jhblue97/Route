
/**
 * bitcoin websocket
 */
	
/*onconnect = function (e) {
	console.log('gggg');
	let bitcoin_ko;
	var count = 0;
 	let port = e.ports[0];
	port.onmessage = function (e) {

		let ws = new WebSocket("wss://api.upbit.com/websocket/v1");
					ws.binaryType = 'arraybuffer';				
					ws.onopen = function(message) {
						// 콘솔 텍스트에 메시지를 출력한다.
						console.log(message);
						//var msg = [{"ticket":"test"},{"type":"ticker","codes":["KRW-BTC","BTC-BCH"]}];
						var msg = [{"ticket":"test"},{"type":"ticker","codes":["KRW-BTC"]}];
				
						ws.send(JSON.stringify(msg));				
					};	
					ws.onclose 	= function(e){ 
						socket = undefined; 
					}
					ws.onmessage= function(e){ 
						//console.log(e);
						var enc = new TextDecoder("utf-8");
						var arr = new Uint8Array(e.data);	
						//console.log(arr);
						var decoe_arr = enc.decode(arr);
						//console.log(decoe_arr);
						var json_arr =JSON.parse(decoe_arr);
						//console.log(json_arr.trade_price);
						
						//bitcoin_ko  = JSON.stringify(json_arr.trade_price);
						bitcoin_ko  = json_arr.trade_price;
						console.log(bitcoin_ko);
						//$('#ko_price').val(bitcoin_ko);
						port.postMessage(bitcoin_ko);
						//alert(bitcoin_ko);
						//ws.close();
				
					}
	}
}*/

var count = 0;
onconnect = function (e) {
// SharedWorker 쓰레드로 받는다. 어떤 스택, 어떤 thread를 실행하더라도 한 개의 쓰래드로 공유된다.
let port = e.ports[0];

	let bitcoin_ko = 'dddd';
	let count = 'ff';
	
	
// postMessage의 값을 받는다.
port.onmessage = function (event) {
	 console.log( 'Worker가 받은 메시지 ', event.data ); 
	let ws = new WebSocket("wss://api.upbit.com/websocket/v1");
					ws.binaryType = 'arraybuffer';				
					ws.onopen = function(message) {
						// 콘솔 텍스트에 메시지를 출력한다.
						console.log(message);
						//var msg = [{"ticket":"test"},{"type":"ticker","codes":["KRW-BTC","BTC-BCH"]}];
						var msg = [{"ticket":"test"},{"type":"ticker","codes":["KRW-BTC"]}];
				
						ws.send(JSON.stringify(msg));				
					};	
					ws.onclose 	= function(e){ 
						socket = undefined; 
					}
					ws.onmessage= function(e){ 
						var enc = new TextDecoder("utf-8");
						var arr = new Uint8Array(e.data);	
						var decoe_arr = enc.decode(arr);
						var json_arr =JSON.parse(decoe_arr);
						bitcoin_ko  = json_arr.trade_price;
						port.postMessage( event.data);
					}
	
// count를 증가 시켜 postMessage를 보낸다.




}
}

