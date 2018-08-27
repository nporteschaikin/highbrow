import React from "react"
import PropTypes from "prop-types"

class TopVenueCategories extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      isReady: false,
    }
  }

  componentDidMount () {
    fetch(this.props.path).
      then(response => response.json()).
      then((rows) => {
        this.setState({
          isReady: true,
          rows: rows,
        });
      });
  }

  render () {
    if (this.state.isReady) {
      return (
        <table className="table table-bordered table-striped">
          <thead>
            <tr>
              <td>Category</td>
              <td>Visits</td>
              <td>Median rating</td>
            </tr>
          </thead>
          <tbody>
            {this.state.rows.map((row) => {
              return (
                <tr key={row.name}>
                  <td>{row.name}</td>
                  <td>{row.check_ins_count}</td>
                  <td>{row.p50_rating}</td>
                </tr>
              );
            })}
          </tbody>
        </table>
      );
    }

    return (
      <p>Loading...</p>
    );
  }
}

TopVenueCategories.propTypes = {
  path: PropTypes.string
};

export default TopVenueCategories
