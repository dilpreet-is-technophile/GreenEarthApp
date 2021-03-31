import "./App.css";
import { BrowserRouter as Router, Switch, Route } from "react-router-dom";
import ImageHome from "./imageHome";
import Blog from "./Blog";
import AllBlogs from "./AllBlogs";
import EditBlog from "./EditBlog";

function App() {
  return (
    <Router>
      <Switch>
        <Route exact path="/">
          <ImageHome />
        </Route>
        <Route exact path="/allblogs">
         <AllBlogs />
        </Route>
        <Route exact path="/blog">
          <Blog />
        </Route>
        <Route exact path="/blog/:blogId">
        <EditBlog />
      </Route>
      </Switch>
    </Router>
  );
}

export default App;
