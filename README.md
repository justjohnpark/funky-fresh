<h1>Funky || Fresh</h1>
<img src="https://travis-ci.org/simensta/funky-fresh.svg?branch=master">
<h2>Purpose</h2>
<p>
Keep your food fresh, not funky, with our kitchen inventory app! Create multiple pantries for any situation, whether you're at home, work, grandma's house, or organizing pantries for a client. Receive daily alert emails for soon-to-expire items, as well as recipe suggestions based on said items. Got roommates? With our app, everyone in your house can stay up to date on what's in the kitchen and cut down on food waste.
</p>

<h2> Getting Started </h2>
<ul>
<li>Fork our repository </li>
<li>Clone your fork </li>
<li>In order to receive recipe suggestions, you will need to add a Yummly API key to your initializer folder. For further instruction, checkout: https://github.com/twmills/yummly.</li>
<li><dt>To setup the database that calculates the expiration date of food items, you will need to:<dt> </li>
    <dd>  rake db:create  </dd>
    <dd>   rake db:migrate </dd>
    <dd>  rake proto </dd>
<li>Open your localhost in a webbrowser (rails s) and start creating pantries. </li>
</ul>

<h2>Dependencies</h2>
<ul>
<li>Yummly API </li>
<li>Yummly Gem (unofficial gem for ruby)</li>
</ul>

<h2>Technologies</h2>
<ul>
<li>Ruby on Rails</li>
<li>jQuery</li>
<li>PostgreSQL</li>
<li>Testing: RSpec, Capybara</li>
</ul>


<h2> Future Features</h2>
<ul>
<li>Barcode scanner</li>
<li>Receipt scanner</li>
<li>Phone app and mobile optimization of current web app</li>
</ul>

<h2> Licenses </h2>

The MIT License (MIT)

Copyright (c) 2014 simensta

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
